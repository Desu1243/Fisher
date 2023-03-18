import 'FlashCard.dart';

class LearningProgress{
  int progress = 0;
  int knownTerms = 0;
  int unknownTerms = 0;
  bool doneLearning = false;
  List<FlashCard> unKnownTermsList = List.empty(growable: true);
}