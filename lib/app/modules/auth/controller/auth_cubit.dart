import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gold_express/app/modules/auth/controller/auth_state.dart';

class AuthBloc extends Cubit<AuthState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthBloc() : super(AuthStateEmpty());

  Future<void> login() async {
    emit(AuthState.loading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      emailController.clear();
      passwordController.clear();
      emit(AuthState.regular());
    } catch (e) {
      emit(AuthState.error());
    }
  }
}
