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
    var showData = data.collection;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: theme.secondary,
        backgroundColor: theme.background,
        elevation: 0,
        title: Text(data.title),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz_rounded))
        ],
      ),
      body: Column(
        children: [
          Container(
            color: theme.primary,
            height: 200,
            child: ListView.builder(
              itemCount: data.collection.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) => GestureDetector(
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: Card(
                    color: theme.secondary,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: SizedBox(
                      height: 150,
                      width: 300,
                      child: Center(
                          child: Text(showData[index].term, style: TextStyle(fontSize: 18, color: theme.primary, fontWeight: FontWeight.bold),)
                      ),
                    ),
                  ),
                ),
                onTap: (){
                    setState((){
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
                Text(data.title, style: TextStyle(color: theme.secondary, fontWeight: FontWeight.bold, fontSize: 18),),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: VerticalDivider(width: 2.0, color: theme.secondary, thickness: 2.0),
                ),
                Text("${data.collection.length} terms", style: TextStyle(color: theme.secondary)),
              ],
            ),
          ),
        )
        ],
      ),
    );
  }
}
