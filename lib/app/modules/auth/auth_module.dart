import 'package:flutter_modular/flutter_modular.dart';
import './auth_page.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => AuthPage(controller: Modular.get())),
  ];
}
