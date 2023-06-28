import 'package:astronautas_app/app/modules/home/cubit/home_cubit.dart';
import 'package:astronautas_app/app/modules/profile/cubit/profile_controller.dart';
import 'package:astronautas_app/app/modules/profile/cubit/profile_state.dart';
import 'package:astronautas_app/app/widgets/button_widget.dart';
import 'package:astronautas_app/app/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfilePage extends StatefulWidget {
  final HomeController controller;
  final ProfileController profileController;
  const ProfilePage(
      {super.key, required this.controller, required this.profileController});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ProfileController, ProfileState>(
        bloc: widget.profileController,
        listener: (context, state) {
          state.maybeWhen(
            regular: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  actions: [
                    FilledButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Ok'))
                  ],
                  content: const Text('Senha alterada com sucesso!'),
                ),
              );
            },
            orElse: () {},
          );
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Nome: '),
                  TextFieldWidget(
                    enabled: false,
                    textEditingController: TextEditingController(
                        text: widget.controller.user.nome ?? ''),
                  ),
                  Text('Telefone: '),
                  TextFieldWidget(
                    enabled: false,
                    textEditingController: TextEditingController(
                        text: widget.controller.user.telefone ?? ''),
                  ),
                  Text('Email: '),
                  TextFieldWidget(
                    enabled: false,
                    textEditingController: TextEditingController(
                        text: widget.controller.user.email ?? ''),
                  ),
                  Text('Vencimento: '),
                  TextFieldWidget(
                    enabled: false,
                    textEditingController: TextEditingController(
                        text: DateFormat('dd/MM/yyyy').format(
                            widget.controller.user.validoAte!.toDate())),
                  ),
                  ButtonWidget(
                    label: 'Alterar senha',
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            scrollable: true,
                            content: Form(
                              key: widget.profileController.formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text('Nova senha: '),
                                  TextFieldWidget(
                                    obscureText: true,
                                    textEditingController: widget
                                        .profileController
                                        .newPassword1Controller,
                                    onChanged: (value) {
                                      widget.profileController
                                          .updateCanChange();
                                    },
                                    validator: (value) {
                                      if (value !=
                                          widget.profileController
                                              .newPassword2Controller.text) {
                                        return 'As senhas não coincidem!';
                                      }
                                      return null;
                                    },
                                  ),
                                  Text('Nova senha: '),
                                  TextFieldWidget(
                                    obscureText: true,
                                    textEditingController: widget
                                        .profileController
                                        .newPassword2Controller,
                                    onChanged: (value) {
                                      widget.profileController
                                          .updateCanChange();
                                    },
                                    validator: (value) {
                                      if (value !=
                                          widget.profileController
                                              .newPassword1Controller.text) {
                                        return 'As senhas não coincidem!';
                                      }
                                      return null;
                                    },
                                  ),
                                  BlocBuilder<ProfileController, ProfileState>(
                                    bloc: widget.profileController,
                                    builder: (context, state) {
                                      return ButtonWidget(
                                        label: 'Ok',
                                        onPressed: widget.profileController
                                                .canChangePassword
                                            ? () {
                                                if (widget.profileController
                                                    .formKey.currentState!
                                                    .validate()) {
                                                  Navigator.pop(context);
                                                  widget.profileController
                                                      .changePassword();
                                                }
                                              }
                                            : null,
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  ButtonWidget(
                    label: 'Solicitar alteração',
                    onPressed: () async {
                      await launchUrlString(widget.controller.openWhatsapp);
                    },
                  ),
                  ButtonWidget.danger(
                    label: 'Excluir conta',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
