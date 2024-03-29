import 'dart:io';
import 'package:fisher/models/FlashCard.dart';
import 'package:fisher/models/FlashCardCollection.dart';
import 'package:fisher/pages/create.dart';
import 'package:fisher/pages/learn.dart';
import 'package:fisher/pages/qrexport.dart';
import 'package:fisher/services/ImportExport.dart';
import 'package:fisher/widgets/DeleteCollection.dart';
import 'package:flutter/material.dart';
import 'package:fisher/services/Languages.dart';
import '../services/Themes.dart';

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
    ColorScheme theme = Themes.themes[Themes.themeId];
    List<FlashCard> showData = List.of(data.collection);
    ImportExport export = ImportExport();
    Map<String, String> language = Lang.languages[Lang.langId];

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        foregroundColor: theme.secondary,
        backgroundColor: theme.background,
        elevation: 0,
        title: Text(data.title),
        actions: [
          IconButton(
              onPressed: () async {
                /// open a page with QR code with collection to share
                await export.exportCollectionQR(data);
                if (context.mounted) {
                  if (export.dataQR != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QRExportPage(
                                collectionTitle: data.title,
                                codeData: export.dataQR!)));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                            language['cards.qrToolong']!,
                            style: TextStyle(color: theme.background),
                          ),
                          backgroundColor: theme.secondary),
                    );
                  }
                }
              },
              icon: const Icon(Icons.qr_code_2_outlined)),
          IconButton(
              onPressed: () async {
                /// export collection and save it in a file
                await export.exportCollection(data);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                          (export.exportMessage
                              ? language['cards.qrExportSuccess']!
                              : language['cards.qrExportFail']!),
                          style: TextStyle(color: theme.background),
                        ),
                        backgroundColor: theme.secondary),
                  );
                }
              },
              icon: const Icon(Icons.upload_rounded)),
          DeleteCollection(selectedCollection: data),
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CreatePage(data: data, editMode: true)));
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
                          child: Stack(
                        children: [

                          if (showData[index].toggle)
                            if (showData[index].image != "")
                              if (File(showData[index].image).existsSync())
                                Center(
                                  child: Image.file(
                                    File(showData[index].image),
                                    height: 130,
                                  ),
                                ),
                          Container(
                            alignment: Alignment.center,
                            child: Stack(
                              children: [Text(
                                showData[index].toggle ? showData[index].term : showData[index].definition,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  foreground: Paint()..style = PaintingStyle.stroke..strokeWidth = 3..color = theme.secondary,
                                ),
                              ),
                                Text(
                                  showData[index].toggle ? showData[index].term : showData[index].definition,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: theme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),]
                            ),
                          ),
                        ],
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
                      "${data.collection.length} ${data.collection.length > 1 ? language['cards.terms']! : language['cards.term']!}",
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
                        backgroundColor:
                            MaterialStatePropertyAll(theme.primary),
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
                        language['cards.learnFlashCards']!,
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
                        backgroundColor:
                            MaterialStatePropertyAll(theme.primary),
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
                        language['cards.learnTermsDef']!,
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
                    language['cards.flashCards']!,
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
