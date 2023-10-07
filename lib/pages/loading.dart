import 'package:fisher/pages/home.dart';
import 'package:fisher/services/Collections.dart';
import 'package:fisher/services/Themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/Languages.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  ///get data from database
  void setupFlashCardsCollections() async {
    Collections collections = Collections();
    Lang langService = Lang();
    Themes themeService = Themes();
    await collections.getData();
    await langService.getLang();
    await themeService.getTheme();
    if(context.mounted){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(flashCardCollection: collections.collectionList)));
    }
  }

  @override
  void initState() {
    super.initState();
    setupFlashCardsCollections();
  }
  @override
  Widget build(BuildContext context) {
    //ColorScheme theme = Theme.of(context).colorScheme;
    return const Scaffold(
      backgroundColor: Color.fromRGBO(60, 62, 60, 1),
      body: SpinKitRotatingPlain(
        color: Color.fromRGBO(235, 240, 235, 1),
        size: 40,
      ),
    );
  }
}

