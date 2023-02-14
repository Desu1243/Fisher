import 'FlashCard.dart';

class FlashCardCollection{
  late String title; //title of the collection, shown on the home screen
  late List<FlashCard> collection; //flash cards that are part of a collection

  FlashCardCollection({
    required this.title,
    required this.collection
  });
}