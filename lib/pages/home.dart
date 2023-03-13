import 'package:fisher/pages/settings.dart';
import 'package:flutter/material.dart';

import '../models/FlashCardCollection.dart';
import '../services/Themes.dart';
import 'cards.dart';
import 'create.dart';

class HomePage extends StatefulWidget {
  final List<FlashCardCollection> flashCardCollection;
  const HomePage({super.key, required this.flashCardCollection});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    var collections = widget.flashCardCollection;

    return Scaffold(
      backgroundColor: theme.onPrimary,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
            child: ScrollableCollections(
              listOfCollections: collections,
              scrollController: scrollController,
            )),
      ),
      bottomNavigationBar:
          HomeNavigationBar(
              scrollController: scrollController,
              listOfCollections: collections
          ),
    );
  }
}

class ScrollableCollections extends StatelessWidget {
  final List<FlashCardCollection> listOfCollections;
  final ScrollController scrollController;
  const ScrollableCollections({
      super.key,
      required this.listOfCollections,
      required this.scrollController
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    var collections = listOfCollections;

    Widget homePageContent;
    if (collections.isEmpty) {
      homePageContent = Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
            'Click on the plus sign at the bottom to create your first flash card collection.',
            style: TextStyle(color: theme.secondary, fontSize: 24),
            textAlign: TextAlign.center),
      );
    } else {
      homePageContent = ListView.builder(
        controller: scrollController,
        itemCount: collections.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CardsPage(collection: collections[index]),
                ));
          },
          child: Card(
            color: theme.secondary,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: SizedBox(
              height: 150,
              child: Center(
                  child: Text(
                collections[index].title,
                style: TextStyle(
                    fontSize: 18,
                    color: theme.primary,
                    fontWeight: FontWeight.bold),
              )),
            ),
          ),
        ),
      );
    }

    return homePageContent;
  }
}

class HomeNavigationBar extends StatelessWidget {
  final ScrollController scrollController;
  final List<FlashCardCollection> listOfCollections;
  const HomeNavigationBar({
    super.key,
    required this.scrollController,
    required this.listOfCollections,
  });



  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;

    return Container(
      color: theme.background,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /// home button
          IconButton(
              icon: const Icon(Icons.home_filled),
              iconSize: 48,
              color: theme.secondary,
              onPressed: () {
                /// scrolls to the top of the flash cards list
                if(listOfCollections.isNotEmpty) {
                  scrollController.animateTo(
                      scrollController.position.minScrollExtent,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 300));
                }
              }),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
            child: VerticalDivider(
                width: 2.0, color: theme.secondary, thickness: 2.0),
          ),
          /// create flash card collection button
          IconButton(
              icon: const Icon(Icons.add_circle),
              iconSize: 48,
              color: theme.secondary,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CreatePage()));
              }),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
            child: VerticalDivider(
                width: 2.0, color: theme.secondary, thickness: 2.0),
          ),
          /// settings button
          IconButton(
              icon: const Icon(Icons.settings),
              iconSize: 48,
              color: theme.secondary,
              onPressed: () async {
                Themes themeService = Themes();
                await themeService.getTheme();
                Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(themeId: themeService.themeId)));
              }),
        ],
      ),
    );
  }
}
