import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/services.dart';

var kColorScheme = ColorScheme.fromSeed(
  // method to create different shades of colors based on the seedColor
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp],
  // ).then((value) {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // showSemanticsDebugger: true,
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            // in some cases styleFrom() method is used instead of the copyWith() method
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
        appBarTheme:
            const AppBarTheme().copyWith(backgroundColor: Colors.black),
      ),
      theme: ThemeData().copyWith(
        // by using copyWith, I priviledged to override properties of from the ThemeData() constructor function or any other theming constructor
        // such as AppTheme, CardTheme and other themes
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.onSecondary,
          margin: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              // in some cases styleFrom() method is used instead of the copyWith() method
              backgroundColor: kColorScheme.onSecondary),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: kColorScheme.onSecondaryContainer,
              ),
            ),
      ),
      themeMode: ThemeMode.system,
      home: const Expenses(),
    ),
  );
  // });
}
