import 'package:astronautas_app/app/modules/profile/cubit/profile_controller.dart';
import 'package:astronautas_app/app/modules/profile/profile_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileModule extends Module {
  @override
  List<Bind<Object>> get binds => [Bind((i) => ProfileController())];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => ProfilePage(
            controller: Modular.get(),
            profileController: Modular.get(),
          ),
        )
      ];
}
