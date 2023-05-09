import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gold_express/app/modules/auth/controller/auth_cubit.dart';
import 'package:gold_express/app/modules/auth/controller/auth_state.dart';
import 'package:gold_express/app/widgets/button_widget.dart';
import 'package:gold_express/app/widgets/loading_dialog.dart';
import 'package:gold_express/app/widgets/text_field_widget.dart';

class AuthPage extends StatelessWidget {
  final AuthBloc controller;

  const AuthPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        bloc: controller,
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
        child: SingleChildScrollView(
            child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  AppBar().preferredSize.height),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  TextFieldWidget(
                    textEditingController: controller.emailController,
                    labelText: 'Email',
                    hintText: 'Seu melhor email',
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
                    textEditingController: controller.passwordController,
                    labelText: 'Senha',
                    obscureText: true,
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: ButtonWidget(
                label: 'Entrar',
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    controller.login();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
