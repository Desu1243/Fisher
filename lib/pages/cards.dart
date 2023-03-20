import 'package:fisher/models/FlashCard.dart';
import 'package:fisher/models/FlashCardCollection.dart';
import 'package:fisher/pages/edit.dart';
import 'package:fisher/pages/learn.dart';
import 'package:fisher/pages/learnRandom.dart';
import 'package:fisher/services/Collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

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

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        foregroundColor: theme.secondary,
        backgroundColor: theme.background,
        elevation: 0,
        title: Text(data.title),
        actions: [
          DeleteCollection(collectionId: data.id),
          IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditPage(data: data)));
          }, icon: const Icon(Icons.edit))
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
                  Text(
                    data.title,
                    style: TextStyle(
                        color: theme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 0.5),
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
                                builder: (context) =>
                                    LearnPage(flashCardCollection: data),
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
                            builder: (context) =>
                                LearnRandomPage(flashCardCollection: data),
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

///delete collection button in top right corner of the screen
class DeleteCollection extends StatelessWidget {
  final int collectionId;
  const DeleteCollection({super.key, required this.collectionId});

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    return IconButton(
        onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                backgroundColor: theme.background,
                title: Text('Delete collection?',
                    style: TextStyle(color: theme.secondary)),
                content: Text(
                    'You are about to delete this flash card collection. Are you sure?',
                    style: TextStyle(color: theme.secondary)),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async {
                      /// remove collection from database
                      Collections instance = Collections();
                      await instance.deleteCollection(collectionId);
                      Phoenix.rebirth(context);
                    },
                    child:
                        Text('Yes', style: TextStyle(color: theme.onSurface)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: Text('No', style: TextStyle(color: theme.onError)),
                  ),
                ],
              ),
            ),
        icon: const Icon(Icons.delete_rounded));
  }
}
