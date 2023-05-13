import 'dart:convert';
import 'package:fisher/models/FlashCardCollection.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Collections{
  late List<FlashCardCollection> collectionList = List.empty(growable: true);


  Collections(){
    () async {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
    }();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/fisherData.txt');
  }


  /// Gets data from fisherData.txt file and sets it as collectionList
  Future<void> getData() async {
    try{
      List<FlashCardCollection> collections = List.empty(growable: true);
      /// get fisher data file
      final fisherDataFile = await _localFile;
      if(await fisherDataFile.exists()) {
        ///get data from file
        String fisherFileData = fisherDataFile.readAsStringSync();
        var fisherData = jsonDecode(fisherFileData);

        ///convert data to list of flash card collections
        for (int i = 0; i < fisherData.length; i++) {
          FlashCardCollection fromFileCollection = FlashCardCollection.fromJson(fisherData[i]);
          collections.add(fromFileCollection);
        }
        collectionList = collections;
      }else{
        collectionList = List.empty(growable: true);
        await fisherDataFile.writeAsString("[]");
      }

    }catch(e){
      collectionList = List.empty(growable: true);
    }
  }

  /// Saves new collection in fisherData file
  Future<void> saveCollection(FlashCardCollection flashCardCollection) async {
    try{
      List<FlashCardCollection> collections = List.empty(growable: true);
      /// get fisher data file
      final fisherDataFile = await _localFile;
      if(await fisherDataFile.exists()){
        ///get data from file
        List fisherData = jsonDecode(fisherDataFile.readAsStringSync());

        ///convert data to list of flash card collections
        for(int i = 0; i < fisherData.length; i++){
          FlashCardCollection fromFileCollection = FlashCardCollection.fromJson(fisherData[i]);
          collections.add(fromFileCollection);
        }
        /// add new collection to list of collections
        collections.add(flashCardCollection);

        List jsonCollections = List.empty(growable: true);
        ///convert to json
        for(int i = 0; i < collections.length; i++){
          jsonCollections.add(jsonEncode(collections[i].toMap()));
        }
        ///save data in file
        await fisherDataFile.writeAsString(jsonCollections.toString());
      }else{
        /// if there is no file, just save one element list in file
        List jsonCollections = List.empty(growable: true);
        jsonCollections.add(jsonEncode(flashCardCollection.toMap()));
        await fisherDataFile.writeAsString(jsonEncode(jsonCollections.toString()));
      }

    }catch(e){
      print("saveC $e");
    }
  }


  /// removes selected collection from data file
  Future<void> deleteCollection(FlashCardCollection selectedCollection) async {
    try{
      List<FlashCardCollection> collections = List.empty(growable: true);
      /// get fisher data file
      final fisherDataFile = await _localFile;
      if(await fisherDataFile.exists()) {
        ///get data from file
        List fisherData = jsonDecode(fisherDataFile.readAsStringSync());

        ///convert data to list of flash card collections
        collections = List<FlashCardCollection>.from(fisherData.map((fc)=>FlashCardCollection.fromJson(fc)));

        var indexToDelete = collections.indexWhere((element) => element.title == selectedCollection.title);
        if(collections[indexToDelete].collection.length == selectedCollection.collection.length) {
          collections.removeAt(indexToDelete);
        }

        List jsonCollections = List.empty(growable: true);
        ///convert to json
        for(int i = 0; i < collections.length; i++){
          jsonCollections.add(jsonEncode(collections[i].toMap()));
        }
        ///save data in file
        await fisherDataFile.writeAsString(jsonCollections.toString());
      }
    }catch(e){
      print("delC $e");
    }
  }
}