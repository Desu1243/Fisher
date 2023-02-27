import 'package:fisher/models/FlashCard.dart';
import 'package:flutter/material.dart';
import '../models/FlashCardCollection.dart';

class LearnPage extends StatefulWidget {
  final FlashCardCollection flashCardCollection;
  late FlashCardCollection shuffledCollection;
  LearnPage({super.key, required this.flashCardCollection}){
    List<FlashCard> shuffledCollection = [...flashCardCollection.collection];
    shuffledCollection.shuffle();
  }

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  int progress = 0;
  int knownTerms = 0;
  int unknownTerms = 0;

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;


    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.background,
        foregroundColor: theme.secondary,
        title: Text("${progress + 1}/${collection.length}"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: theme.error),
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Text(unknownTerms.toString(),
                    style: TextStyle(color: theme.error, fontSize: 18)),
              ),
              Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: theme.surface),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                child: Text(knownTerms.toString(),
                    style: TextStyle(color: theme.surface, fontSize: 18)),
              )
            ],
          )
        ],
      ),
      bottomNavigationBar: Row( ///buttons :D
        children: [
          Expanded( ///don't know button :(
            child: ElevatedButton(
                onPressed: () => {
                  print(shuffledCollection[0].term),
                  progress++,
                  unknownTerms++,
                  ///next card

                  setState(() {})
                },
                style: ButtonStyle(
                    shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(50)))),
                backgroundColor: MaterialStateProperty.all(theme.error),),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(Icons.clear_rounded, color: theme.background, size: 50),
                )),
          ),
          Expanded( ///know button :)
            child: ElevatedButton(
                onPressed: () => {
                  progress++,
                  knownTerms++,
                  ///next card
                },
                style: ButtonStyle(
                  shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(50)))),
                  backgroundColor: MaterialStateProperty.all(theme.surface),),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(Icons.check_rounded, color: theme.background, size: 50),
                )),
          )
        ],
      ),
    );
  }
}
