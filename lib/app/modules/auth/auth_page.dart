import 'package:astronautas_app/app/core/app_colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:astronautas_app/app/modules/auth/controller/auth_cubit.dart';
import 'package:astronautas_app/app/modules/auth/controller/auth_state.dart';
import 'package:astronautas_app/app/widgets/button_widget.dart';
import 'package:astronautas_app/app/widgets/loading_dialog.dart';
import 'package:astronautas_app/app/widgets/text_field_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AuthPage extends StatefulWidget {
  final AuthBloc controller;

  const AuthPage({
    super.key,
    required this.controller,
  });

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        bloc: widget.controller,
        listener: (context, state) {
          state.maybeWhen(
            loading: () => showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const LoadingDialog(),
            ),
            regular: () => Modular.to.pushReplacementNamed('/home/'),
            error: () {
              Modular.to.pop();
            },
            orElse: () {},
          );
        },
        child: Align(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: widget.controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icon.png',
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFieldWidget(
                    textEditingController: widget.controller.emailController,
                    labelText: 'Email',
                    hintText: 'Seu melhor email',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Por favor, informe um email!';
                      } else if (!EmailValidator.validate(email)) {
                        return 'Informe um email válido!';
                      }
                      return null;
                    },
                  ),
                  TextFieldWidget(
                    textEditingController: widget.controller.passwordController,
                    labelText: 'Senha',
                    obscureText: true,
                  ),
                  ButtonWidget(
                    label: 'Entrar',
                    onPressed: () {
                      if (widget.controller.formKey.currentState!.validate()) {
                        widget.controller.login();
                      }
                    },
                  ),
                  TextButton(
                    onPressed: () async {
                      try {
                        await launchUrlString(widget.controller.openWhatsapp);
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Center(
                                child: Icon(
                                  Icons.dangerous,
                                  color: AppColors.primary,
                                ),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                      'Infelizmente nosso registro é feito via Whatsapp e não encontramos o aplicativo instalado neste dispositivo!'),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  ButtonWidget(
                                    label: 'Ok',
                                    onPressed: () {
                                      Modular.to.pop();
                                    },
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: const Text('Registrar-se'),
                  )
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
