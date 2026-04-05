import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/tabs.dart';

final owntheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(                              // Own ColorScheme
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),                         // Own TextTheme
);

void main() {
  runApp(
    const ProviderScope(           // Provided by the Riverpod Functionality.
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: owntheme,
      home: const TabsScreen(),
    );
  }
}