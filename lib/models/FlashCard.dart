class FlashCard{
  late int id;
  late String term; //term user wants to learn
  late String definition; //definition (or translation) of that term
  String image = "";
  bool toggle = true;

  FlashCard({
    required this.term,
    required this.definition,
    this.image = ""
  });

  Map<String, dynamic> toMap(int collectionId) {
    return {
      'collection_id': collectionId,
      'term': term,
      'definition': definition,
      'image': image
    };
  }

  FlashCard.fromJson(Map<String, dynamic> json){
    term = json['t'];
    definition = json['d'];
    if(json['i'] != null){
      image = json['i'];
    }
  }
}