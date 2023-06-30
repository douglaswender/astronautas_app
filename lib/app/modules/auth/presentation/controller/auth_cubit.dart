import 'package:astronautas_app/app/modules/auth/domain/repositories/login_repository.dart';
import 'package:astronautas_app/app/modules/auth/domain/usecases/login/login_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_state.dart';

class AuthBloc extends Cubit<AuthState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late UserCredential userCredential;

  final LoginUsecase _usecase;
  AuthBloc(this._usecase) : super(AuthStateEmpty());

  final openWhatsapp =
      'whatsapp://send?phone=+5569993203759&text=Quero me registrar no Astronautas Express!';

  Future<void> login() async {
    emit(AuthState.loading());
    final response = await _usecase(
        params: LoginParams(
            email: emailController.text, password: passwordController.text));

    response.fold((l) {
      if (l.error is FirebaseAuthException) {
        emit(AuthState.invalidPassword());
      } else {
        emit(AuthState.error());
      }
    }, (r) => emit(AuthState.regular()));
  }
}
