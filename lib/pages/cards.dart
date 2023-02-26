import 'package:fisher/models/FlashCard.dart';
import 'package:fisher/models/FlashCardCollection.dart';
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
    List<FlashCard> showData = data.collection.map((item)=>item).toList();

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        foregroundColor: theme.secondary,
        backgroundColor: theme.background,
        elevation: 0,
        title: Text(data.title),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded))
        ],
      ),
      body: Column(
        children: [
          Container(
            color: theme.primary,
            height: 180,
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
                        showData[index].term,
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
                    var temp = showData[index].term;
                    showData[index].term = showData[index].definition;
                    showData[index].definition = temp;
                  });
                },
              ),
            ),
          ),
          Container(
            color: theme.background,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: VerticalDivider(
                        width: 2.0, color: theme.onPrimary, thickness: 2.0),
                  ),
                  Text("${data.collection.length} terms",
                      style: TextStyle(color: theme.secondary)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () => {},
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 20, 20),
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
          Container(
            color: theme.background,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                      child: SizedBox(
                        height: 80,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(data.collection[index].term,
                                  style: TextStyle(
                                      color: theme.secondary, fontSize: 18)),
                              Text(data.collection[index].definition,
                                  style: TextStyle(
                                      color: theme.secondary, fontSize: 18)),
                            ],
                          ),
                        ),
                      ),
                    )),
          )
        ],
      ),
    );
  }
}
