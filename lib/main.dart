import 'package:fisher/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';


Future<void> getDatabase() async{
  var db = await openDatabase('fisher.db');
  ///idk
}

void main() {
  List<ThemeData> themes = [
    ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromRGBO(27, 86, 83, 1.0), ///1A5653 //forest green
          secondary: Color.fromRGBO(208, 249, 207, 1.0), ///D0F9CF //light lime green
          background: Color.fromRGBO(8, 49, 59, 1.0), ///08313A //dark forest green
          surface: Color.fromRGBO(101, 239, 99, 1.0), ///65E063 //lime green
          onPrimary: Color.fromRGBO(16, 114, 100, 1.0), ///107264 //teal green

          error: Color.fromRGBO(1, 1, 1, 0.0),
          onSecondary: Color.fromRGBO(1, 1, 1, 0.0),
          onBackground: Color.fromRGBO(1, 1, 1, 0.0),
          onSurface: Color.fromRGBO(101, 239, 99, 1.0), ///E06363 //red
          onError: Color.fromRGBO(249, 99, 99, 1.0), ///65E063 //green
        ),
        brightness: Brightness.light,
    ),

  ];

  runApp(MaterialApp(
    home: const LoadingPage(),
    theme: themes[0],
    ),
  );
}
