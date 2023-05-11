import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gold_express/app/modules/home/cubit/delivery_model.dart';
import 'package:gold_express/app/modules/home/cubit/home_state.dart';
import 'package:gold_express/app/modules/home/cubit/user_model.dart';
import 'package:ntp/ntp.dart';

class HomeController extends Cubit<HomeState> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  UserModel user = UserModel();
  HomeController() : super(HomeState.empty());
  List<DeliveryModel> lastRequests = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController destinoController = TextEditingController();

  Future<void> logout() async {
    emit(HomeState.loading());
    await auth.signOut();
    emit(HomeState.unauthenticated());
  }

  Future<void> getLoggedUser() async {
    emit(HomeState.loading());
    lastRequests.clear();
    final email = auth.currentUser?.email;
    final userType = await db.collection('usuarios').doc(email).get();
    if (userType.data()!['tipo'] == 'cliente') {
      await db
          .collection('clientes')
          .doc(email)
          .get()
          .then((value) => user = user.copyWith(name: value.data()?['nome']));
      await db
          .collection('entregas')
          .where('cliente', isEqualTo: email)
          .orderBy('timestamp', descending: true)
          .get()
          .then((value) async {
        for (var e in value.docs) {
          bool exists = e.data()['motoboy'] != '';
          if (exists) {
            final motoboy =
                await db.collection('motoboys').doc(e.data()['motoboy']).get();
            lastRequests.add(DeliveryModel.fromMap(e.data()).copyWith(
                cliente: user,
                motoboy: UserModel.fromMap(motoboy.data()!)
                    .copyWith(email: e.data()['motoboy'])));
          } else {
            lastRequests.add(DeliveryModel.fromMap(e.data()).copyWith(
                cliente: user, motoboy: UserModel(name: 'A definir')));
          }
        }
      });
    } else {
      await db
          .collection('motoboys')
          .doc(email)
          .get()
          .then((value) => user = user.copyWith(
                name: value.data()?['nome'],
                email: email,
              ));
      await db
          .collection('entregas')
          .where('motoboy', isEqualTo: email)
          .orderBy('timestamp', descending: true)
          .get()
          .then((value) async {
        for (var e in value.docs) {
          final cliente =
              await db.collection('clientes').doc(e.data()['cliente']).get();
          lastRequests.add(DeliveryModel.fromMap(e.data()).copyWith(
              cliente: UserModel.fromMap(cliente.data()!)
                  .copyWith(email: e.data()['cliente']),
              motoboy: user));
        }
      });
      // .then((value) => value.docs
      //     .map((e) => lastRequests.add(DeliveryModel.fromMap(e.data()))));
    }
    user = user.copyWith(email: email, tipo: userType.data()!['tipo']);
    emit(HomeState.regular());
  }

  Future<void> publishDelivery() async {
    emit(HomeState.loading());
    final queue = await db
        .collection('fila')
        .doc('ouro-preto')
        .get()
        .then((value) => value.data());

    final nestedQueue = queue?['fila'] as List;
    if (nestedQueue.isEmpty) {
      emit(HomeState.unavaliable());
    } else {
      final first = nestedQueue.removeAt(0);
      nestedQueue.add(first);

      await db.collection('entregas').add({
        'cliente': user.email,
        'endereco_destino': destinoController.text,
        'motoboy': first,
        'status': 'aguardando',
        'valor_entrega': 6,
        'timestamp': await NTP.now(),
      });

      //TODO: send notification to first

      await db.collection('fila').doc('ouro-preto').set({'fila': nestedQueue});
      getLoggedUser();
    }
  }
}
