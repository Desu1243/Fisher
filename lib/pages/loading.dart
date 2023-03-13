import 'package:fisher/pages/home.dart';
import 'package:fisher/services/Collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  ///get data from database
  void setupFlashCardsCollections() async {
    Collections collections = Collections();
    await collections.getData();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(flashCardCollection: collections.collectionList)));
  }

  @override
  void initState() {
    super.initState();
    setupFlashCardsCollections();
  }
  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.onPrimary,
      body: SpinKitRotatingPlain(
        color: theme.secondary,
        size: 40,
      ),
    );
  }
}

