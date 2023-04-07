import 'package:fisher/models/FlashCardCollection.dart';

class ImportExport{
  late FlashCardCollection data;

  getData() async {
    ///get file
    ///read and convert flashcard collection form file
    ///set imported fcc as this.data
    ///close file
  }

  exportCollection(FlashCardCollection data) async {
    ///create file named as title.json
    ///convert fcc to json string
    ///save json in file
    ///close file
  }
}