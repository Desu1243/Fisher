import 'package:fisher/pages/cards.dart';
import 'package:fisher/pages/home.dart';
import 'package:fisher/pages/learn.dart';
import 'package:fisher/pages/loading.dart';
import 'package:fisher/pages/create.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: LoadingPage(),
    theme: ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color.fromRGBO(27, 86, 83, 1.0), //1A5653 //forest green
        secondary: Color.fromRGBO(208, 249, 207, 1.0), //D0F9CF //light lime green
        background: Color.fromRGBO(8, 49, 59, 1.0), //08313A //dark forest green
        surface: Color.fromRGBO(101, 239, 99, 1.0), //65E063 //lime green
        error: Color.fromRGBO(249, 99, 99, 1.0), //E06363 //red
        onPrimary: Color.fromRGBO(16, 114, 100, 1.0), //107264 //teal green

        onSecondary: Color.fromRGBO(8, 49, 59, 0.0),
        onBackground: Color.fromRGBO(8, 49, 59, 0.0),
        onSurface: Color.fromRGBO(8, 49, 59, 0.0),
        onError: Color.fromRGBO(8, 49, 59, 0.0),
      ),
      brightness: Brightness.light,
    ),
  ));
}
