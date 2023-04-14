import 'package:fisher/models/FlashCardCollection.dart';
import 'dart:io';


class ImportExport{
  late FlashCardCollection data;
  late Directory localPath;

  writeFile(int count) async {
    //localPath = await getApplicationDocumentsDirectory();
    localPath = Directory("applicationDocumentsPath/Fisher");
    File localFile = File("${localPath.path}/counter.txt");
    await localFile.writeAsString("$count");
    print("done writing");
  }

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