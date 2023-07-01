import 'package:astronautas_app/app/modules/home/data/datasource/logout_datasource.dart';
import 'package:astronautas_app/app/modules/home/data/datasource/logout_datasource_imp.dart';
import 'package:astronautas_app/app/modules/home/data/datasource/user_datasource.dart';
import 'package:astronautas_app/app/modules/home/data/datasource/user_datasource_imp.dart';
import 'package:astronautas_app/app/modules/home/data/repositories/logout_repository_imp.dart';
import 'package:astronautas_app/app/modules/home/data/repositories/user_repository_imp.dart';
import 'package:astronautas_app/app/modules/home/domain/repositories/logout_repository.dart';
import 'package:astronautas_app/app/modules/home/domain/repositories/user_repository.dart';
import 'package:astronautas_app/app/modules/home/domain/usecases/get_logged_user/get_logged_user_usecase.dart';
import 'package:astronautas_app/app/modules/home/domain/usecases/get_logged_user/get_logged_user_usecase_imp.dart';
import 'package:astronautas_app/app/modules/home/domain/usecases/logout/logout_usecase.dart';
import 'package:astronautas_app/app/modules/home/domain/usecases/logout/logout_usecase_imp.dart';
import 'package:astronautas_app/app/modules/home/unavailable_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:astronautas_app/app/modules/home/cubit/home_cubit.dart';
import './home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    //datasources
    Bind.lazySingleton<LogoutDatasource>((i) => LogoutDatasourceImp(
        FirebaseFirestore.instance,
        FirebaseAuth.instance,
        FirebaseMessaging.instance)),
    Bind.lazySingleton<UserDatasource>((i) => UserDatasourceImp(
          FirebaseFirestore.instance,
        )),

    //repositories
    Bind.lazySingleton<LogoutRepository>((i) => LogoutRepositoryImp(i.get())),
    Bind.lazySingleton<UserRepository>((i) => UserRepositoryImp(i.get())),

    //usecases
    Bind.lazySingleton<LogoutUsecase>((i) => LogoutUsecaseImp(i.get())),
    Bind.lazySingleton<GetLoggedUserUsecase>(
        (i) => GetLoggedUserUsecaseImp(i.get())),

    //controllers
    Bind.lazySingleton((i) => HomeController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => HomePage(controller: Modular.get())),
    ChildRoute(
      '/unavaliable',
      child: (context, args) => UnavaliablePage(controller: Modular.get()),
    )
  ];
}
