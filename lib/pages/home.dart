import 'package:flutter/material.dart';

import '../models/FlashCardCollection.dart';
import 'create.dart';

class HomePage extends StatefulWidget {
  final List<FlashCardCollection> flashCardCollection;
  const HomePage({super.key, required this.flashCardCollection});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    ColorScheme theme = Theme.of(context).colorScheme;

    var data = widget.flashCardCollection;
    print(data.length);

    return Scaffold(
      backgroundColor: theme.onPrimary,
      bottomNavigationBar: const HomeNavigationBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Text('Click on a plus sign at the bottom to create your first flash card collection.',
                style: TextStyle(color: theme.secondary, fontSize: 24), textAlign: TextAlign.center,),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;

    return Container(
      color: theme.background,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(icon: const Icon(Icons.home_filled), iconSize: 48,
              color: theme.secondary, onPressed: (){

              }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
            child: VerticalDivider(width: 2.0, color: theme.secondary, thickness: 2.0),
          ),
          IconButton(icon: const Icon(Icons.add_circle), iconSize: 48,
              color: theme.secondary, onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePage()));
              }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
            child: VerticalDivider(width: 2.0, color: theme.secondary, thickness: 2.0),
          ),
          IconButton(icon: const Icon(Icons.settings), iconSize: 48,
              color: theme.secondary, onPressed: (){

              }),
        ],
      ),
    );
  }
}
