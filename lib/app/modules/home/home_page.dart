import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gold_express/app/core/app_colors.dart';
import 'package:gold_express/app/modules/home/cubit/home_cubit.dart';
import 'package:gold_express/app/modules/home/cubit/home_state.dart';
import 'package:gold_express/app/widgets/button_widget.dart';
import 'package:gold_express/app/widgets/loading_dialog.dart';

class HomePage extends StatefulWidget {
  final HomeController controller;

  const HomePage({
    super.key,
    required this.controller,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await widget.controller.getLoggedUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<HomeController, HomeState>(
              bloc: widget.controller,
              builder: (context, state) {
                return UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: AppColors.secondary,
                    backgroundImage: AssetImage(
                        widget.controller.user.tipo == 'cliente'
                            ? 'assets/loja.png'
                            : 'assets/moto.png'),
                  ),
                  accountName: Text(widget.controller.user.name ?? ''),
                  accountEmail: Text(widget.controller.user.email ?? ''),
                );
              },
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  BlocBuilder<HomeController, HomeState>(
                    bloc: widget.controller,
                    builder: (context, state) {
                      return ListTile(
                        title: Text(widget.controller.user.tipo != 'cliente'
                            ? 'Minhas entregas'
                            : 'Meus envios'),
                        onTap: () {},
                      );
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: ButtonWidget(
                label: 'Sair',
                onPressed: () => widget.controller.logout(),
              ),
            )
            // DrawerHeader(
            //   decoration: BoxDecoration(color: AppColors.primary),
            //   child: Text('GOLD EXPRESS'),
            // ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Gold Express'),
      ),
      body: BlocListener<HomeController, HomeState>(
        bloc: widget.controller,
        listener: (context, state) {
          state.maybeWhen(
            loading: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const LoadingDialog());
            },
            unauthenticated: () => Modular.to.pushReplacementNamed('/auth/'),
            regular: () {
              Modular.to.pop();
            },
            orElse: () {},
          );
        },
        child: Container(),
      ),
    );
  }
}
