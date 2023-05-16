import 'package:flutter_modular/flutter_modular.dart';
import 'package:astronautas_app/app/modules/home/cubit/home_cubit.dart';
import './home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => HomePage(controller: Modular.get())),
  ];
}
