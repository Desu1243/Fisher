import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:fisher/models/FlashCard.dart';
import 'package:fisher/models/FlashCardCollection.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';


class ImportExport{
  late FlashCardCollection data;
  String exportMessage = "Collection successfully exported";

  getData() async {
    /// check or request permissions to manage files
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();

    /// open file selector
    FilePickerResult? selectedFile = await FilePicker.platform.pickFiles(allowMultiple: false);

    if(selectedFile != null){
      /// convert json from file to map
      File dataToImportJSON = File(selectedFile.files.first.path as String);
      Map fileData = jsonDecode(dataToImportJSON.readAsStringSync());

      /// convert map to FlashCardCollection object
      List<FlashCard> flashCardList = List.empty(growable: true);
      for(int i=0; i < fileData['c'].length; i++){
        flashCardList.add(FlashCard(
            term: fileData['c'][i]['t'],
            definition: fileData['c'][i]['d'])
        );
      }
      FlashCardCollection newCollection = FlashCardCollection(id: 0,
          title: fileData['t'],
          collection: flashCardList);

      /// set flash card collection as data
      data = newCollection;
    }
  }

  exportCollection(FlashCardCollection data) async {
    /// check or request permissions to manage files
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();

    /// convert collection to json
    Map dataToExport = data.toJSON();

    /// select directory to save exported file in
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    /// save data in file if possible
    if (selectedDirectory != null) {
      try{
        File localFile = File("$selectedDirectory/${data.title}.txt");
        await localFile.writeAsString(dataToExport.toString());
      }catch(e){
        exportMessage = "Something went wrong";
      }
    }
  }
}