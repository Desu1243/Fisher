import 'package:fisher/models/FlashCard.dart';
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
          child: collections.isEmpty
              ?

              /// show text if there are no collections created
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                      'Click on the plus sign at the bottom to create your first flash card collection.',
                      style: TextStyle(color: theme.secondary, fontSize: 24),
                      textAlign: TextAlign.center),
                )
              :

              /// else

              /// show collections
              ListView.builder(
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
                ),
        ),
      ),
      bottomNavigationBar: Container(
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
                  scrollToTop();
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
                  openCreatePage();
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
                  openSettingsPage(themeService.themeId);
                }),
          ],
        ),
      ),
    );
  }

  /// scrolls to the top of the flash cards list
  scrollToTop() {
    if (widget.flashCardCollection.isNotEmpty) {
      scrollController.animateTo(scrollController.position.minScrollExtent,
          curve: Curves.easeOut, duration: const Duration(milliseconds: 300));
    }
  }

  /// opens create page
  openCreatePage() {
    FlashCardCollection emptyCollection = FlashCardCollection(
        id: 0, title: "", collection: [FlashCard(definition: "", term: "")]);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CreatePage(editMode: false, data: emptyCollection)));
  }

  ///opens settings page
  openSettingsPage(int tId) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Settings(themeId: tId)));
  }
}
