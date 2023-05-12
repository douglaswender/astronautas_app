import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gold_express/app/core/app_colors.dart';
import 'package:gold_express/app/modules/home/cubit/delivery_model.dart';
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
                    widget.controller.user.tipo == 'cliente' ? '' : '',
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
        title: const Text(
          'Gold Express',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
                                              Modular.to.pop();
                                              await widget.controller
                                                  .publishDelivery();
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
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
                flex: 3,
                child: Column(
                  children: [
                    const Text('Últimas corridas:'),
                    Expanded(
                      child: BlocBuilder<HomeController, HomeState>(
                        bloc: widget.controller,
                        builder: (context, state) {
                          return StreamBuilder<QuerySnapshot>(
                            stream: widget.controller.lastRequestStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Há algo errado aqui');
                              }

                              if (snapshot.connectionState ==
                                      ConnectionState.waiting ||
                                  !snapshot.hasData) {
                                return const Text('Carregando...');
                              }

                              return ListView(
                                children: snapshot.data?.docs.map((e) {
                                      DeliveryModel data =
                                          DeliveryModel.fromMap(
                                              e.data() as Map<String, dynamic>);
                                      return ListTile(
                                        onTap: () {},
                                        title: BlocBuilder<HomeController,
                                            HomeState>(
                                          bloc: widget.controller,
                                          builder: (context, state) {
                                            return Text(
                                                widget.controller.user.tipo ==
                                                        'cliente'
                                                    ? data.motoboy!.nome
                                                    : data.cliente!.nome);
                                          },
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(data.enderecoDestino!),
                                            Text(
                                                'Valor: R\$ ${data.valorEntrega!.toStringAsFixed(2).replaceAll('.', ',')}'),
                                            Text('Status: ${data.status!}'),
                                          ],
                                        ),
                                      );
                                    }).toList() ??
                                    [],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
