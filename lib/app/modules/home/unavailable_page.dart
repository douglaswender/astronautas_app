import 'package:astronautas_app/app/modules/home/cubit/home_cubit.dart';
import 'package:astronautas_app/app/modules/home/cubit/home_state.dart';
import 'package:astronautas_app/app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UnavaliablePage extends StatefulWidget {
  final HomeController controller;
  const UnavaliablePage({super.key, required this.controller});

  @override
  State<UnavaliablePage> createState() => _UnavaliablePageState();
}

class _UnavaliablePageState extends State<UnavaliablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HomeController, HomeState>(
        bloc: widget.controller,
        listener: (context, state) {
          state.maybeWhen(
            unauthenticated: () => Modular.to.pushReplacementNamed('/auth/'),
            orElse: () {},
          );
        },
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/icon2.png',
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              const Text(
                'Infelizmente seu usuário está bloqueado aguardando pagamento ou liberação da equipe de suporte. Caso tenha pago, entre em contato com o suporte.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16,
              ),
              ButtonWidget(
                label: 'Ligue',
                onPressed: () {
                  launchUrlString('tel:+5569993203759');
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ButtonWidget(
                label: 'Whatsapp',
                onPressed: () {
                  launchUrlString('whatsapp://send?phone=+5569993203759');
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ButtonWidget(
                label: 'Sair',
                onPressed: () {
                  widget.controller.logout();
                },
              ),
            ],
          ),
        )),
      ),
    );
  }
}
