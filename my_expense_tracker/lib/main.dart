import 'package:flutter/material.dart';
import 'package:my_expense_tracker/user_expense.dart';
import 'package:flutter/services.dart';

final kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 17, 73, 169),
);

final kDarkScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 0, 39, 46),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: kDarkScheme,
          cardTheme: const CardTheme().copyWith(
            color: kDarkScheme.onSecondary,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kDarkScheme.onSecondaryContainer,
                foregroundColor: kDarkScheme.onSecondary),
          ),
        ),
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme,
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.onSecondary,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          appBarTheme: const AppBarTheme().copyWith(
            foregroundColor: kColorScheme.onPrimary,
            backgroundColor: kColorScheme.onPrimaryContainer,
          ),
          textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
                color: kColorScheme.onSecondary,
              ),
              titleMedium: TextStyle(
                fontSize: 16,
                color: kColorScheme.onSecondary,
              )),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kColorScheme.onSecondaryContainer,
                foregroundColor: kColorScheme.onSecondary),
          ),
        ),
        home: const UserExpense(),
        themeMode: ThemeMode.system,
      ),
    );
  });
}
