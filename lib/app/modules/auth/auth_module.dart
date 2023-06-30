import 'package:astronautas_app/app/modules/auth/data/datasources/login_datasource.dart';
import 'package:astronautas_app/app/modules/auth/data/datasources/login_datasource_imp.dart';
import 'package:astronautas_app/app/modules/auth/data/repositories/login_repository_imp.dart';
import 'package:astronautas_app/app/modules/auth/domain/repositories/login_repository.dart';
import 'package:astronautas_app/app/modules/auth/domain/usecases/login/login_usecase.dart';
import 'package:astronautas_app/app/modules/auth/domain/usecases/login/login_usecase_imp.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'presentation/auth_page.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    //datasources
    Bind<LoginDatasource>((i) => LoginDatasourceImp()),

    //repositories
    Bind<LoginRepository>((i) => LoginRepositoryImp(i.get())),

    //usecases
    Bind<LoginUsecase>((i) => LoginUsecaseImp(i.get())),

    //controllers
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => AuthPage(controller: Modular.get())),
  ];
}
