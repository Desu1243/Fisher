import 'package:fisher/pages/loading.dart';
import 'package:fisher/services/Themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Themes themeService = Themes();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  runApp(
    MaterialApp(
      title: "Fisher",
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: Color.fromRGBO(150, 150, 150, 1)
        )
      ),
      home: const LoadingPage(),
    ),
  );
}
