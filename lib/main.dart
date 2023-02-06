import 'package:fisher/pages/cards.dart';
import 'package:fisher/pages/home.dart';
import 'package:fisher/pages/learn.dart';
import 'package:fisher/pages/loading.dart';
import 'package:fisher/pages/create.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => HomePage(),
      '/loading': (context) => LoadingPage(),
      '/create': (context) => CreatePage(),
      '/cards': (context) => CardsPage(),
      '/learn': (context) => LearnPage()
    },
  ));
}
