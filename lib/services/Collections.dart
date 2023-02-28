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
          FlashCard(term: 'placeholder_term', definition: "placeholder_def"),
          FlashCard(term: 'placeholder_term', definition: "placeholder_def"),
          FlashCard(term: 'very very very very very very very very long term', definition: "very very very very very very very very very long definition"),

        ]),
        FlashCardCollection(title: 'Homework', collection: [
          FlashCard(term: 'nuclear warhead', definition: 'funny thing that is in my basement'),
          FlashCard(term: 'apocalypse', definition: "future"),
          FlashCard(term: 'placeholder_term', definition: "placeholder_def"),
          FlashCard(term: 'placeholder_term', definition: "placeholder_def"),
          FlashCard(term: 'placeholder_term', definition: "placeholder_def"),
        ]),

      ];
    });
  }
}