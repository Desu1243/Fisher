import 'package:fisher/pages/loading.dart';
import 'package:fisher/services/Themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

Themes themeService = Themes();

Future<void> startApp() async{
  Themes themes = Themes();
  await themes.getTheme();

  runApp(
    Phoenix(
      child: MaterialApp(
        title: "Fisher",
        home: const LoadingPage(),
        theme: themeService.themes[themes.themeId],
        ),
    ),
  );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  startApp();
}
