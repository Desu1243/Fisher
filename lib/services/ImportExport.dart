import 'package:file_picker/file_picker.dart';
import 'package:fisher/models/FlashCardCollection.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';


class ImportExport{
  late FlashCardCollection data;
  late String fileName;

  Future<String?> get _localPath async {
    final directory = await getDownloadsDirectory();
    return directory?.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  writeFile(int count) async {
    File localFile = await _localFile;
    await localFile.writeAsString("$count");
    print("done writing");
  }

  getData() async {
    ///get file
    ///read and convert flashcard collection form file
    ///set imported fcc as this.data
    ///close file
    File localFile = await _localFile;

  }

  exportCollection(FlashCardCollection data) async {
    ///create file named as title.json
    ///convert fcc to json string
    ///save json in file
    ///close file
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();

    Map dataToExport = data.toJSON();
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      try{
        File localFile = File("$selectedDirectory/${data.title}.json");
        await localFile.writeAsString(dataToExport.toString());
      }catch(e){
        print(e);
      }
    }
  }
}