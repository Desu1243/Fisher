import 'FlashCard.dart';

class FlashCardCollection{
  late String title; //title of the collection, shown on the home screen
  late List<FlashCard> collection; //flash cards that are part of a collection

  FlashCardCollection({
    required this.title,
    required this.collection
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title
    };
  }

  FlashCardCollection.fromJson(Map<String, dynamic> json)
      : title = json['t'],
        collection = json['c'];

  Map<String, dynamic> toJSON(){
    return {
      '"t"': '"$title"',
      '"c"': collection.map((item){
        return {
          '"t"': '"${item.term}"',
          '"d"': '"${item.definition}"'
        };
      }).toList()
    };
  }
}