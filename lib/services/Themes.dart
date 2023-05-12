import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Themes{
  late int themeId;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/fisherTheme.txt');
  }

  Future<void> changeTheme(int number) async{
    try {
      final fisherThemeFile = await _localFile;
      fisherThemeFile.writeAsStringSync('$number');
    }catch(e){
      themeId = 0;
    }
  }

  Future<void> getTheme() async{
    try {
      final fisherThemeFile = await _localFile;
      if(await fisherThemeFile.exists()){
        var themeFileContent = await fisherThemeFile.readAsString();
        themeId = int.parse(themeFileContent);
      }else{
        themeId = 0;
        fisherThemeFile.writeAsStringSync('0');
      }
    }catch(e){
      themeId = 0;
    }
  }

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
        primary: Color.fromRGBO(26, 36, 86, 1.0),
        secondary: Color.fromRGBO(207, 219, 249, 1.0),
        background: Color.fromRGBO(8, 13, 58, 1.0),
        surface: Color.fromRGBO(75, 160, 238, 1.0),
        onPrimary: Color.fromRGBO(16, 55, 114, 1.0),

        error: Color.fromRGBO(1, 1, 1, 0.0),
        onSecondary: Color.fromRGBO(1, 1, 1, 0.0),
        onBackground: Color.fromRGBO(1, 1, 1, 0.0),
        onSurface: Color.fromRGBO(101, 239, 99, 1.0), //E06363 //red
        onError: Color.fromRGBO(249, 99, 99, 1.0), //65E063 //green
      ),
      brightness: Brightness.light,
    ),
  ];
}