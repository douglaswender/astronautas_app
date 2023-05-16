import 'package:astronautas_app/app/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Astronautas Express',
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: AppColors.secondary,
          errorColor: AppColors.danger,
          backgroundColor: AppColors.secondary,
          cardColor: AppColors.primary,
          primarySwatch: const MaterialColor(0xFF7B1FA2, {
            50: Color(0xFF6f1c92),
            100: Color(0xFF621982),
            200: Color(0xFF561671),
            300: Color(0xFF4a1361),
            400: Color(0xFF3e1051),
            500: Color(0xFF310c41),
            600: Color(0xFF250931),
            700: Color(0xFF190620),
            800: Color(0xFF0c0310),
            900: Color(0xFF000000),
          }),
          //accentColor: Colors.red,
        ),
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
