import 'package:flutter/material.dart';

import '../models/FlashCardCollection.dart';
import 'cards.dart';
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
    var collections = widget.flashCardCollection;


    return Scaffold(
      backgroundColor: theme.onPrimary,
      bottomNavigationBar: const HomeNavigationBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
          child: ScrollableCollections(listOfCollections: collections,)
        ),
      ),
    );
  }
}

class ScrollableCollections extends StatelessWidget {

  final List<FlashCardCollection> listOfCollections;
  const ScrollableCollections({super.key, required this.listOfCollections});

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    var collections = listOfCollections;

    Widget scrollableCollections;
    if(collections.isEmpty){
      scrollableCollections = Text('Click on a plus sign at the bottom to create your first flash card collection.',
        style: TextStyle(color: theme.secondary, fontSize: 24), textAlign: TextAlign.center);
    }else{
      scrollableCollections = ListView.builder(
        itemCount: collections.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) => GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => CardsPage(collection: collections[index]),));
          },
          child: Card(
            color: theme.secondary,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: SizedBox(
              height: 150,
              child: Center(
                  child: Text(collections[index].title, style: TextStyle(fontSize: 18, color: theme.primary),)
              ),
            ),
          ),
        ),
      );
    }

    return scrollableCollections;
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
