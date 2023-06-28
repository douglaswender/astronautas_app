import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:astronautas_app/app/modules/auth/controller/auth_state.dart';

class AuthBloc extends Cubit<AuthState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late UserCredential userCredential;
  AuthBloc() : super(AuthStateEmpty());

  final openWhatsapp =
      'whatsapp://send?phone=+5569993203759&text=Quero me registrar no Astronautas Express!';

  Future<void> login() async {
    emit(AuthState.loading());
    try {
      final user = userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      emailController.clear();
      passwordController.clear();
      final deviceTokens = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.user?.email)
          .get()
          .then((value) => value.data()?['tokens'] as List?);
      String? thisDeviceToken = await FirebaseMessaging.instance.getToken();
      if (deviceTokens != null && deviceTokens.isNotEmpty) {
        if (!deviceTokens.contains(thisDeviceToken)) {
          deviceTokens.add(thisDeviceToken);
        }

        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(user.user?.email)
            .update({
          "tokens": deviceTokens,
        });
      } else {
        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(user.user?.email)
            .update({
          "tokens": [thisDeviceToken],
        });
      }

      emit(AuthState.regular());
    } catch (e) {
      emit(AuthState.error());
    }
  }
}
