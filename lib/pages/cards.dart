import 'package:fisher/models/FlashCard.dart';
import 'package:fisher/models/FlashCardCollection.dart';
import 'package:fisher/pages/create.dart';
import 'package:fisher/pages/learn.dart';
import 'package:fisher/services/ImportExport.dart';
import 'package:fisher/widgets/DeleteCollection.dart';
import 'package:flutter/material.dart';

class CardsPage extends StatefulWidget {
  final FlashCardCollection collection;
  const CardsPage({super.key, required this.collection});

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  @override
  Widget build(BuildContext context) {
    FlashCardCollection data = widget.collection;
    ColorScheme theme = Theme.of(context).colorScheme;
    List<FlashCard> showData = List.of(data.collection);
    ImportExport export = ImportExport();

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        foregroundColor: theme.secondary,
        backgroundColor: theme.background,
        elevation: 0,
        title: Text(data.title),
        actions: [
          IconButton(onPressed: () async {
            /// export collection and save it in a file
            await export.exportCollection(data);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                    export.exportMessage,
                    style: TextStyle(color: theme.background),
                  ),
                  backgroundColor: theme.secondary),
            );
          }, icon: const Icon(Icons.upload_rounded)),
          DeleteCollection(collectionId: data.id),
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreatePage(data: data, editMode: true)));
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: Column(
        children: [
          /// scrollable horizontally flash cards collection
          Container(
            color: theme.primary,
            height: 180,
            width: double.infinity,
            child: ListView.builder(
              itemCount: data.collection.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) => GestureDetector(
                child: Container(
                  margin: const EdgeInsets.all(15),
                  child: Card(
                    color: theme.secondary,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: SizedBox(
                      height: 150,
                      width: 300,
                      child: Center(
                          child: Text(
                        showData[index].toggle
                            ? showData[index].term
                            : showData[index].definition,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: theme.primary,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    showData[index].toggle = !showData[index].toggle;
                  });
                },
              ),
            ),
          ),

          /// flash card title and term count
          Container(
            color: theme.background,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      data.title,
                      style: TextStyle(
                          color: theme.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 0.5),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      child: Container(
                        color: theme.secondary,
                        height: 16,
                        width: 1,
                      )),
                  Text(
                      "${data.collection.length} ${data.collection.length > 1 ? "terms" : "term"}",
                      style: TextStyle(color: theme.secondary, fontSize: 15)),
                ],
              ),
            ),
          ),

          /// learn using flash cards button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LearnPage(
                                    flashCardCollection: data,
                                    randomizedMode: false),
                              ))
                        },
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 15, 15, 15),
                        child: Icon(
                          Icons.menu_book,
                          color: theme.surface,
                        ),
                      ),
                      Text(
                        "Learn using flash cards",
                        style: TextStyle(color: theme.secondary, fontSize: 18),
                      )
                    ]))
              ],
            ),
          ),

          ///randomized learning button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LearnPage(
                                    flashCardCollection: data,
                                    randomizedMode: true),
                              ))
                        },
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 15, 15, 15),
                        child: Icon(
                          Icons.autorenew_rounded,
                          color: theme.surface,
                        ),
                      ),
                      Text(
                        "Learn terms and definitions",
                        style: TextStyle(color: theme.secondary, fontSize: 18),
                      )
                    ]))
              ],
            ),
          ),

          /// "Flash cards" divider
          Container(
            color: theme.background,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Row(
                children: [
                  Text(
                    "Flash cards",
                    style: TextStyle(
                        color: theme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 0.5),
                  ),
                ],
              ),
            ),
          ),

          /// scrollable flash card list on bottom with terms and definitions
          Expanded(
            child: ListView.builder(
                itemCount: data.collection.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) => Card(
                      color: theme.primary,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(data.collection[index].term,
                                style: TextStyle(
                                    color: theme.secondary, fontSize: 18)),
                            Divider(
                              height: 15,
                              color: theme.primary,
                            ),
                            Text(data.collection[index].definition,
                                style: TextStyle(
                                    color: theme.secondary, fontSize: 18)),
                          ],
                        ),
                      ),
                    )),
          )
        ],
      ),
    );
  }
}