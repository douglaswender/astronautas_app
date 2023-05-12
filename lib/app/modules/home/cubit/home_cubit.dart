import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gold_express/app/core/notification_service.dart';
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
  Stream<QuerySnapshot>? lastRequestStream;

  Future<void> logout() async {
    emit(HomeState.loading());

    final userRef = db.collection('usuarios').doc(user.email!);
    List currentTokens =
        await userRef.get().then((value) => value.data()?['tokens'] ?? []);
    currentTokens.remove(await FirebaseMessaging.instance.getToken());
    userRef.update({
      'tokens': currentTokens,
    });
    await auth.signOut();
    emit(HomeState.unauthenticated());
  }

  Future<void> getLoggedUser() async {
    emit(HomeState.loading());
    lastRequests.clear();
    final email = auth.currentUser?.email;
    final userType = await db.collection('usuarios').doc(email).get();
    if (userType.data()!['tipo'] == 'cliente') {
      final cliente = await db
          .collection('clientes')
          .doc(email)
          .get()
          .then((value) => value.data());
      lastRequestStream = db
          .collection('entregas')
          .where('cliente', isEqualTo: cliente)
          .orderBy('timestamp', descending: true)
          .snapshots();
      // await db
      //     .collection('entregas')
      //     .where('cliente', isEqualTo: email)
      //     .orderBy('timestamp', descending: true)
      //     .get()
      //     .then((value) async {
      //   for (var e in value.docs) {
      //     final motoboy =
      //         await db.collection('motoboys').doc(e.data()['motoboy']).get();
      //     lastRequests.add(DeliveryModel.fromMap(e.data()).copyWith(
      //         cliente: user,
      //         motoboy: UserModel.fromMap(motoboy.data()!)
      //             .copyWith(email: e.data()['motoboy'])));
      //   }
      // });
    } else {
      await db
          .collection('motoboys')
          .doc(email)
          .get()
          .then((value) => user = user.copyWith(
                email: email,
              ));
      final motoboy = await db
          .collection('motoboys')
          .doc(email)
          .get()
          .then((value) => value.data());
      lastRequestStream = db
          .collection('entregas')
          .where('motoboy', isEqualTo: motoboy)
          .orderBy('timestamp', descending: true)
          .snapshots();
      // await db
      //     .collection('entregas')
      //     .where('motoboy', isEqualTo: email)
      //     .orderBy('timestamp', descending: true)
      //     .get()
      //     .then((value) async {
      //   for (var e in value.docs) {
      //     final cliente =
      //         await db.collection('clientes').doc(e.data()['cliente']).get();
      //     lastRequests.add(DeliveryModel.fromMap(e.data()).copyWith(
      //         cliente: UserModel.fromMap(cliente.data()!)
      //             .copyWith(email: e.data()['cliente']),
      //         motoboy: Motoboy));
      //   }
      // });
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

      final motoboy = await db
          .collection('motoboys')
          .doc(first)
          .get()
          .then((value) => value.data());

      final cliente = await db
          .collection('clientes')
          .doc(auth.currentUser?.email)
          .get()
          .then((value) => value.data());

      await db.collection('entregas').add({
        'cliente': cliente,
        'enderecoDestino': destinoController.text,
        'motoboy': motoboy,
        'status': 'aguardando',
        'valorEntrega': 6,
        'timestamp': await NTP.now(),
      });

      final firstTokens = await db
          .collection('usuarios')
          .doc(first)
          .get()
          .then((value) => value.data()?['tokens'] as List? ?? []);

      NotificationService.sendUserNotification(
          tokens: firstTokens, body: 'Uma nova corrida para você aceitar!');

      await db.collection('fila').doc('ouro-preto').set({'fila': nestedQueue});
      emit(HomeState.regular());
    }
  }
}
