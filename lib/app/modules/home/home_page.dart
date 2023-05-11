import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gold_express/app/core/app_colors.dart';
import 'package:gold_express/app/modules/home/cubit/home_cubit.dart';
import 'package:gold_express/app/modules/home/cubit/home_state.dart';
import 'package:gold_express/app/widgets/button_widget.dart';
import 'package:gold_express/app/widgets/loading_dialog.dart';
import 'package:gold_express/app/widgets/text_field_widget.dart';

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
                  accountName: Text(
                    widget.controller.user.name ?? '',
                    style: const TextStyle(color: AppColors.black),
                  ),
                  accountEmail: Text(
                    widget.controller.user.email ?? '',
                    style: const TextStyle(color: AppColors.black),
                  ),
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
                        onTap: () {
                          Modular.to.pop();
                        },
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
            unavaliable: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Center(
                    child: Icon(Icons.dangerous),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                          'Infelizmente não temos entregadores disponíveis no momento, acesse a aba "entregadores disponíveis" para conferir!'),
                    ],
                  ),
                  actions: [
                    ButtonWidget(
                      label: 'Ok',
                      onPressed: () {
                        Modular.to.pop();
                        Modular.to.pop();
                      },
                    )
                  ],
                ),
              );
            },
            unauthenticated: () => Modular.to.pushReplacementNamed('/auth/'),
            regular: () {
              Modular.to.pop();
            },
            orElse: () {},
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<HomeController, HomeState>(
                  bloc: widget.controller,
                  builder: (context, state) {
                    return state.maybeWhen(
                      regular: () {
                        if (widget.controller.user.tipo == 'cliente') {
                          return ButtonWidget(
                            label: 'Solicitar corrida',
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: Form(
                                    key: widget.controller.formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        TextFieldWidget(
                                          labelText: 'Endereço de Destino',
                                          textEditingController: widget
                                              .controller.destinoController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Por favor, informe um destino';
                                            }
                                            return null;
                                          },
                                        ),
                                        ButtonWidget(
                                          label: 'Enviar',
                                          onPressed: () async {
                                            if (widget.controller.formKey
                                                .currentState!
                                                .validate()) {
                                              await widget.controller
                                                  .publishDelivery();
                                              Modular.to.pop();
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),

                                  //actionsAlignment: MainAxisAlignment.center,
                                ),
                              );
                            },
                          );
                        } else {
                          return const Text('Não há corridas no momento');
                        }
                      },
                      orElse: () {
                        return const SizedBox();
                      },
                    );
                  },
                ),
              ],
            )),
            Expanded(
              child: BlocBuilder<HomeController, HomeState>(
                bloc: widget.controller,
                builder: (context, state) {
                  return state.maybeWhen(
                    regular: () => Column(
                      children: [
                        const Text('Últimas corridas:'),
                        Expanded(
                          child: ListView.builder(
                            itemCount: widget.controller.lastRequests.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {},
                                title: BlocBuilder<HomeController, HomeState>(
                                  bloc: widget.controller,
                                  builder: (context, state) {
                                    return Text(
                                        widget.controller.user.tipo == 'cliente'
                                            ? widget
                                                .controller
                                                .lastRequests[index]
                                                .motoboy!
                                                .name!
                                            : widget
                                                .controller
                                                .lastRequests[index]
                                                .cliente!
                                                .name!);
                                  },
                                ),
                                subtitle: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(widget.controller.lastRequests[index]
                                        .enderecoDestino!),
                                    Text(
                                        'Valor: R\$ ${widget.controller.lastRequests[index].valorEntrega!.toStringAsFixed(2).replaceAll('.', ',')}'),
                                    Text(
                                        'Status: ${widget.controller.lastRequests[index].status!}'),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    orElse: () => const SizedBox(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
