import 'package:astronautas_app/app/modules/profile/profile_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:astronautas_app/app/modules/auth/auth_module.dart';
import 'package:astronautas_app/app/modules/auth/controller/auth_cubit.dart';
import 'package:astronautas_app/app/modules/home/home_module.dart';
import 'modules/splash/splash_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => AuthBloc()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/auth', module: AuthModule()),
        ChildRoute('/', child: (context, args) => const SplashPage()),
        ModuleRoute('/home', module: HomeModule()),
        ModuleRoute('/profile', module: ProfileModule()),
      ];
}
