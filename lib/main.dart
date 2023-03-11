import 'package:fisher/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

List<ThemeData> themes = [
  /// forest green - default
  ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromRGBO(27, 86, 83, 1.0), //1A5653 //forest green
      secondary: Color.fromRGBO(208, 249, 207, 1.0), //D0F9CF //light lime green
      background: Color.fromRGBO(8, 49, 59, 1.0), //08313A //dark forest green
      surface: Color.fromRGBO(101, 239, 99, 1.0), //65E063 //lime green
      onPrimary: Color.fromRGBO(16, 114, 100, 1.0), //107264 //teal green

      error: Color.fromRGBO(1, 1, 1, 0.0),
      onSecondary: Color.fromRGBO(1, 1, 1, 0.0),
      onBackground: Color.fromRGBO(1, 1, 1, 0.0),
      onSurface: Color.fromRGBO(101, 239, 99, 1.0), //E06363 //red
      onError: Color.fromRGBO(249, 99, 99, 1.0), //65E063 //green
    ),
    brightness: Brightness.light,
  ),

  /// purple haze
  ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromRGBO(74, 26, 86, 1.0),
      secondary: Color.fromRGBO(238, 207, 249, 1.0),
      background: Color.fromRGBO(51, 8, 58, 1.0),
      surface: Color.fromRGBO(199, 99, 224, 1.0),
      onPrimary: Color.fromRGBO(88, 16, 114, 1.0),

      error: Color.fromRGBO(1, 1, 1, 0.0),
      onSecondary: Color.fromRGBO(1, 1, 1, 0.0),
      onBackground: Color.fromRGBO(1, 1, 1, 0.0),
      onSurface: Color.fromRGBO(101, 239, 99, 1.0), //E06363 //red
      onError: Color.fromRGBO(249, 99, 99, 1.0), //65E063 //green
    ),
    brightness: Brightness.light,
  ),

  /// Blue sky
  ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromRGBO(74, 26, 86, 1.0),
      secondary: Color.fromRGBO(238, 207, 249, 1.0),
      background: Color.fromRGBO(51, 8, 58, 1.0),
      surface: Color.fromRGBO(199, 99, 224, 1.0),
      onPrimary: Color.fromRGBO(88, 16, 114, 1.0),

      error: Color.fromRGBO(1, 1, 1, 0.0),
      onSecondary: Color.fromRGBO(1, 1, 1, 0.0),
      onBackground: Color.fromRGBO(1, 1, 1, 0.0),
      onSurface: Color.fromRGBO(101, 239, 99, 1.0), //E06363 //red
      onError: Color.fromRGBO(249, 99, 99, 1.0), //65E063 //green
    ),
    brightness: Brightness.light,
  ),
];

Future<void> getTheme() async{
  var themeIndex = 0;
  try {
    var db = await openDatabase('fisher.db');
    await db.execute(
        "CREATE TABLE IF NOT EXISTS theme (id INT NOT NULL, theme_number INT NOT NULL, PRIMARY KEY (id))");
    List<Map> dbThemes = await db.rawQuery('SELECT * FROM theme');
    if (dbThemes.isEmpty) {
      await db.transaction((txn) async {
        int id1 = await txn.rawInsert(
            'INSERT INTO theme(id, theme_number) VALUES(1, 0)');
      });
    } else {
      themeIndex = dbThemes[0]['theme_number'];
    }
  }catch(e){
    print(e);
  }

  runApp(MaterialApp(
    home: const LoadingPage(),
    theme: themes[themeIndex],
    ),
  );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getTheme();
}
