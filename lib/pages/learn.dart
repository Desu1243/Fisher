import 'dart:math';
import 'package:fisher/models/FlashCard.dart';
import 'package:fisher/services/Learning.dart';
import 'package:flutter/material.dart';
import '../models/FlashCardCollection.dart';
import '../widgets/LearningFlashCard.dart';

class LearnPage extends StatefulWidget {
  final FlashCardCollection flashCardCollection;
  final bool randomizedMode;

  const LearnPage({super.key, required this.flashCardCollection, required this.randomizedMode});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  late Learning learning;
  List<FlashCard> collection = List.empty();
  Random rnd = Random();

  @override
  void initState() {
    collection = [...widget.flashCardCollection.collection];

    learning = Learning(collection: collection, randomMode: widget.randomizedMode);
    super.initState();
  }

  void dontKnowPressed(){
    setState(() {
      learning.dontKnowPressed();
    });
  }

  void knowPressed(){
    setState((){
      learning.knowPressed();
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    List<FlashCard> collection = widget.flashCardCollection.collection;

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.background,
        foregroundColor: theme.secondary,
        title: Text("${learning.progress + 1}/${collection.length}"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          /// score bar
          if (!learning.doneLearning)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: theme.onError),
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Text("${learning.unknownTerms}",
                      style: TextStyle(color: theme.onError, fontSize: 18)),
                ),
                Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: theme.onSurface),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10))),
                  child: Text("${learning.knownTerms}",
                      style: TextStyle(color: theme.onSurface, fontSize: 18)),
                )
              ],
            ),

          /// flash card
          Expanded(
              child: GestureDetector(
                  onTap: () => {
                    learning.shuffledCollection[learning.progress].toggle =
                            !learning.shuffledCollection[learning.progress].toggle,
                        setState(() => {})
                      },
                  child: LearningFlashCard(
                    card: learning.shuffledCollection[learning.progress],
                    learning: learning,
                  )))
        ],
      ),

      /// buttons
      bottomNavigationBar: Row(
        children: [
          if (!learning.doneLearning)
            Expanded(
              /// don't know button :(
              child: ElevatedButton(
                  onPressed: () {
                      dontKnowPressed();
                  },
                  style: ButtonStyle(
                    shape: const MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50)))),
                    backgroundColor: MaterialStateProperty.all(theme.onError),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(Icons.clear_rounded,
                        color: theme.background, size: 50),
                  )),
            ),
          if (!learning.doneLearning)
            Expanded(
              /// know button :)
              child: ElevatedButton(
                  onPressed: (){
                        knowPressed();
                  },
                  style: ButtonStyle(
                    shape: const MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50)))),
                    backgroundColor: MaterialStateProperty.all(theme.onSurface),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(Icons.check_rounded,
                        color: theme.background, size: 50),
                  )),
            )
        ],
      ),
    );
  }
}
