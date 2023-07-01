import 'dart:convert';
import 'package:astronautas_app/app/modules/home/domain/entities/client_entity.dart';
import 'package:astronautas_app/app/modules/home/domain/entities/motoboy_entity.dart';
import 'package:astronautas_app/app/modules/home/domain/entities/user_entity.dart';
import 'package:astronautas_app/app/modules/home/domain/usecases/get_client/get_client_usecase.dart';
import 'package:astronautas_app/app/modules/home/domain/usecases/get_client_deliveries/get_client_deliveries_usecase.dart';
import 'package:astronautas_app/app/modules/home/domain/usecases/get_logged_user/get_logged_user_usecase.dart';
import 'package:astronautas_app/app/modules/home/domain/usecases/get_motoboy/get_motoboy_usecase.dart';
import 'package:astronautas_app/app/modules/home/domain/usecases/get_motoboy_deliveries/get_motoboy_deliveries_usecase.dart';
import 'package:astronautas_app/app/modules/home/domain/usecases/logout/logout_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:astronautas_app/app/core/notification_service.dart';
import 'package:astronautas_app/app/modules/home/cubit/delivery_model.dart';
import 'package:astronautas_app/app/modules/home/cubit/home_state.dart';
import 'package:astronautas_app/app/modules/home/cubit/motoboy_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ntp/ntp.dart';

class HomeController extends Cubit<HomeState> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  UserEntity user = UserEntity();
  ClientEntity? clientEntity;
  HomeController() : super(HomeState.empty());
  List<DeliveryModel> lastRequests = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController qtdEntrega = TextEditingController();
  Stream<QuerySnapshot>? lastRequestStream;
  MotoboyEntity? motoboy;
  bool trabalhando = false;

  String get openWhatsapp =>
      'whatsapp://send?phone=+5569993203759&text=Quero alterar minha conta! Meu email é: ${user.email}';

  Future<void> logout() async {
    emit(HomeState.loading());

    final response = await Modular.get<LogoutUsecase>()(email: user.email!);

    response.fold(
      (l) => emit(HomeState.error()),
      (r) => emit(HomeState.unauthenticated()),
    );
  }

  Future<void> initialize() async {
    emit(HomeState.loading());
    lastRequests.clear();
    final email = auth.currentUser?.email;
    final getLoggedUser =
        await Modular.get<GetLoggedUserUsecase>()(email: email ?? '');

    getLoggedUser.fold((l) => emit(HomeState.error()), (r) => user = r);

    if (user.tipo == 'cliente') {
      final getClient =
          await Modular.get<GetClientUsecase>()(email: email ?? '');

      getClient.fold((l) => emit(HomeState.error()), (r) => clientEntity = r);

      final getDeliveries = await Modular.get<GetClientDeliveriesUsecase>()(
          client: clientEntity!);

      getDeliveries.fold(
          (l) => emit(HomeState.error()), (r) => lastRequestStream = r);
    } else {
      final getMotoboy =
          await Modular.get<GetMotoboyUsecase>()(email: email ?? '');

      getMotoboy.fold((l) => emit(HomeState.error()), (r) {
        trabalhando = r.trabalhando ?? false;
        motoboy = r;
      });

      final getDeliveries =
          await Modular.get<GetMotoboyDeliveriesUsecase>()(motoboy: motoboy!);

      getDeliveries.fold(
          (l) => emit(HomeState.error()), (r) => lastRequestStream = r);
    }
    //user = user.copyWith(email: email, tipo: userData['tipo']);
    if (Timestamp.now().compareTo(user.validoAte!) == 1) {
      emit(HomeState.invalidUser());
    } else if (user.validoAte!.toDate().difference(await NTP.now()).inDays <
        3) {
      emit(HomeState.regularWithDialog());
    } else {
      emit(HomeState.regular());
    }
  }

  Future<void> changeStatus() async {
    emit(HomeState.loading());
    await db.collection('motoboys').doc(user.email).update({
      "trabalhando": !trabalhando,
    });

    final currentList = await db
        .collection('fila')
        .doc('ouro-preto')
        .get()
        .then((value) => value.data()?['fila'] as List);
    if (!trabalhando && !currentList.contains(user.email)) {
      currentList.add(user.email);
    } else {
      currentList.remove(user.email);
    }
    await db.collection('fila').doc('ouro-preto').set({
      'fila': currentList,
    });
    trabalhando = !trabalhando;
    emit(HomeState.regular());
  }

  Future<void> publishDelivery() async {
    emit(HomeState.loading());
    final rc = FirebaseRemoteConfig.instance;
    await rc.fetchAndActivate();
    final valueOfRun = jsonDecode(rc.getValue('value_of_run').asString());
    late String first;
    bool hasMotoboy = false;
    await db.runTransaction((transaction) async {
      final filaRef = db.collection('fila').doc('ouro-preto');

      final queue =
          await transaction.get(filaRef).then((value) => value.data());

      final nestedQueue = queue!['fila'] as List;
      if (nestedQueue.isEmpty) {
        emit(HomeState.unavaliable());
      } else {
        hasMotoboy = true;
        first = nestedQueue.removeAt(0);
        nestedQueue.add(first);

        final firstTokens = await db
            .collection('usuarios')
            .doc(first)
            .get()
            .then((value) => value.data()?['tokens'] as List? ?? []);

        NotificationService.sendUserNotification(
            tokens: firstTokens, body: 'Uma nova corrida para você aceitar!');
        transaction.set(filaRef, {'fila': nestedQueue});
      }
    });
    if (hasMotoboy) {
      final motoboy = await db
          .collection('motoboys')
          .doc(first)
          .get()
          .then((value) => MotoboyModel.fromMap(value.data()!));

      final cliente = await db
          .collection('clientes')
          .doc(auth.currentUser?.email)
          .get()
          .then((value) => value.data());

      await db.collection('entregas').add({
        'cliente': cliente,
        'qtdEntrega': qtdEntrega.text == '' ? 1 : int.parse(qtdEntrega.text),
        'motoboy': motoboy.toMapDelivery(),
        'status': 'aguardando',
        'valorEntrega': valueOfRun['ouro-preto'],
        'timestamp': await NTP.now(),
      });
      emit(HomeState.regular());
    }
  }

  Future<void> getDelivery(String deliveryId) async {
    emit(HomeState.loading());
    await db.collection('entregas').doc(deliveryId).update({
      'status': 'buscando',
    });
    final emailClient = await db
        .collection('entregas')
        .doc(deliveryId)
        .get()
        .then((value) => value.data()!['cliente']['email']);

    final tokens = await db
        .collection('usuarios')
        .doc(emailClient)
        .get()
        .then((value) => value.data()?['tokens'] as List? ?? []);

    NotificationService.sendUserNotification(
        tokens: tokens,
        body: 'Opa, seu entregador já já chega aí!',
        title: '${user.nome} a caminho! 🛵🛵🛵');
    emit(HomeState.regular());
  }

  Future<void> finalizeDelivery(String deliveryId) async {
    emit(HomeState.loading());
    await db.collection('entregas').doc(deliveryId).update({
      'status': 'finalizado',
    });
    final emailClient = await db
        .collection('entregas')
        .doc(deliveryId)
        .get()
        .then((value) => value.data()!['cliente']['email']);

    final tokens = await db
        .collection('usuarios')
        .doc(emailClient)
        .get()
        .then((value) => value.data()?['tokens'] as List? ?? []);

    NotificationService.sendUserNotification(
        tokens: tokens,
        body: 'Obrigado por usar o nosso serviço',
        title: '${user.nome} terminou a corrida! 🛵');
    emit(HomeState.regular());
  }
}
