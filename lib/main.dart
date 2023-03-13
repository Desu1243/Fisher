import 'package:fisher/pages/loading.dart';
import 'package:fisher/services/Themes.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

Themes themeService = Themes();

Future<void> getTheme() async{
  var themeIndex = 0;

  var db = await openDatabase('fisher.db');
  await db.execute(
      "CREATE TABLE IF NOT EXISTS theme (id INT NOT NULL, theme_number INT NOT NULL, PRIMARY KEY (id))");
  List<Map> dbThemes = await db.rawQuery('SELECT * FROM theme');
  if (dbThemes.isEmpty) {
    await db.rawQuery('INSERT INTO theme(id, theme_number) VALUES(1, 0)');
  } else {
    themeIndex = dbThemes[0]['theme_number'];
  }

  runApp(
    Phoenix(
      child: MaterialApp(
        home: const LoadingPage(),
        theme: themeService.themes[themeIndex],
        ),
    ),
  );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getTheme();
}
