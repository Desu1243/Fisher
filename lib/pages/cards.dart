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
    FlashCardCollection collection = widget.collection;
    ColorScheme theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: theme.secondary,
        title: Text(collection.title),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz_rounded))
        ],
      ),
    );
  }
}
