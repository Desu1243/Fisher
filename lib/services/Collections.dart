import 'package:fisher/models/FlashCard.dart';
import 'package:fisher/models/FlashCardCollection.dart';

class Collections{
  late List<FlashCardCollection> collectionList = [];

  Future<void> getData() async {
    await Future.delayed(Duration(seconds: 3),(){
      this.collectionList = [
        FlashCardCollection(title: 'Programming', collection: [
          FlashCard(term: 'programming', definition: 'making electrons do math'),
          FlashCard(term: 'react native', definition: "something I don't use"),
        ]),
        FlashCardCollection(title: 'Homework', collection: [
          FlashCard(term: 'nuclear warhead', definition: 'funny thing that is in ma basement'),
          FlashCard(term: 'apocalypse', definition: "future"),
        ]),
        FlashCardCollection(title: 'Placeholder', collection: [
          FlashCard(term: 'Placeholder', definition: 'text'),
          FlashCard(term: 'Placeholder', definition: "text"),
        ]),
        FlashCardCollection(title: 'Placeholder', collection: [
          FlashCard(term: 'Placeholder', definition: 'text'),
          FlashCard(term: 'Placeholder', definition: "text"),
        ]),
        FlashCardCollection(title: 'Placeholder', collection: [
          FlashCard(term: 'Placeholder', definition: 'text'),
          FlashCard(term: 'Placeholder', definition: "text"),
        ]),
        FlashCardCollection(title: 'Placeholder', collection: [
          FlashCard(term: 'Placeholder', definition: 'text'),
          FlashCard(term: 'Placeholder', definition: "text"),
        ]),
        FlashCardCollection(title: 'Placeholder', collection: [
          FlashCard(term: 'Placeholder', definition: 'text'),
          FlashCard(term: 'Placeholder', definition: "text"),
        ]),
        FlashCardCollection(title: 'Placeholder', collection: [
          FlashCard(term: 'Placeholder', definition: 'text'),
          FlashCard(term: 'Placeholder', definition: "text"),
        ]),

      ];
    });
  }
}