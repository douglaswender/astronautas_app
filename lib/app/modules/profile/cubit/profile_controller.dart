import 'package:astronautas_app/app/modules/profile/cubit/profile_state.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileController extends Cubit<ProfileState> {
  ProfileController() : super(ProfileState.empty());

  TextEditingController newPassword1Controller = TextEditingController();
  TextEditingController newPassword2Controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool canChangePassword = false;

  bool get setCanChangePassword =>
      newPassword1Controller.text.isNotEmpty ||
      newPassword1Controller.text != '' &&
          newPassword2Controller.text.isNotEmpty ||
      newPassword2Controller.text != '';

  void updateCanChange() {
    canChangePassword = setCanChangePassword;
    emit(ProfileState.empty());
  }

  Future<void> changePassword() async {
    emit(ProfileState.loading());
    final auth = FirebaseAuth.instance;
    auth.currentUser!.updatePassword(newPassword1Controller.text);
    emit(ProfileState.regular());
  }
}
