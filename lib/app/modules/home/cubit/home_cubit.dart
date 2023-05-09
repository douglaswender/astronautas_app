import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gold_express/app/modules/home/cubit/home_state.dart';
import 'package:gold_express/app/modules/home/cubit/user_model.dart';

class HomeController extends Cubit<HomeState> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  UserModel user = UserModel();
  HomeController() : super(HomeState.empty());

  Future<void> logout() async {
    emit(HomeState.loading());
    await auth.signOut();
    emit(HomeState.unauthenticated());
  }

  Future<void> getLoggedUser() async {
    emit(HomeState.loading());
    final email = auth.currentUser?.email;
    final userType = await db.collection('usuarios').doc(email).get();
    if (userType.data()!['tipo'] == 'cliente') {
      await db
          .collection('clientes')
          .doc(email)
          .get()
          .then((value) => user = user.copyWith(name: value.data()?['nome']));
    } else {
      await db
          .collection('motoboys')
          .doc(email)
          .get()
          .then((value) => user = user.copyWith(name: value.data()?['nome']));
    }
    user = user.copyWith(email: email, tipo: userType.data()!['tipo']);
    emit(HomeState.regular());
  }
}
