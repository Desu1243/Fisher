import 'dart:math';
import '../models/FlashCard.dart';

class Learning{
  Random rnd = Random();

  int progress = 0;
  int knownTerms = 0;
  int unknownTerms = 0;
  bool doneLearning = false;
  List<FlashCard> unKnownTermsList = List.empty(growable: true);
  List<FlashCard> shuffledCollection = List.empty(growable: true);
  bool randomMode = false;

  Learning({required List<FlashCard> collection, required this.randomMode}){
    collection.shuffle();
    shuffledCollection = collection;

    if(randomMode) {
      shuffledCollection[0].toggle = rnd.nextBool();
    }else{
      shuffledCollection[0].toggle = true;
    }

  }


  void dontKnowPressed(){
      if (!doneLearning) {
        if (progress + 1 < shuffledCollection.length) {
          /// add progress to unknown terms
          unKnownTermsList.add(shuffledCollection[progress]);
          progress++;
          unknownTerms++;
        } else {
          /// add progress to unknown and end learning
          unKnownTermsList.add(shuffledCollection[progress]);
          unknownTerms++;
          doneLearning = true;
        }
      }

      if(randomMode){
        shuffledCollection[progress].toggle = rnd.nextBool();
      }else {
        shuffledCollection[progress].toggle = true;
      }
  }

  void knowPressed(){
      if (!doneLearning)
      {
        if (progress + 1 < shuffledCollection.length)
        {
          /// add progress to known terms
          progress++;
          knownTerms++;
        } else {
          /// add progress to known and end learning
          knownTerms++;
          doneLearning = true;
        }
      }

      if(randomMode){
        shuffledCollection[progress].toggle = rnd.nextBool();
      }else {
        shuffledCollection[progress].toggle = true;
      }
  }

}