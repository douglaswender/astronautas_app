import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Gold Express',
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: const MaterialColor(0xFFFFD700, {
            50: Color(0xFFFFFAE0),
            100: Color(0xFFFFF3B3),
            200: Color(0xFFFFEB80),
            300: Color(0xFFFFE34D),
            400: Color(0xFFFFDD26),
            500: Color(0xFFFFD700),
            600: Color(0xFFFFD300),
            700: Color(0xFFFFCD00),
            800: Color(0xFFFFC700),
            900: Color(0xFFFFBE00),
          }),
          //accentColor: Colors.red,
        ),
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
