import 'dart:convert';
import 'package:fisher/models/FlashCard.dart';
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
        List fisherData = jsonDecode(fisherDataFile.readAsStringSync());

        ///convert data to list of flash card collections
        for (int i = 0; i < fisherData.length; i++) {
          Map fccMap = fisherData[i];
          List<FlashCard> fcList = List.empty(growable: true);
          for (int j = 0; j < fccMap['c'].length; j++) {
            fcList.add(FlashCard(
                term: fccMap['c'][j]['t'], definition: fccMap['c'][j]['d']));
          }
          collections.add(FlashCardCollection(
              title: fccMap['t'], collection: fcList));
        }
        collectionList = collections;
      }else{
        collectionList = List.empty(growable: true);
      }

    }catch(e){
      print(e);
    }
  }

  /// Saves new collection in fisherData file
  Future<void> saveCollection(FlashCardCollection flashCardCollection) async {
    try{
      List collections = List.empty(growable: true);
      /// get fisher data file
      final fisherDataFile = await _localFile;
      if(await fisherDataFile.exists()){
        ///get data from file
        List fisherData = jsonDecode(fisherDataFile.readAsStringSync());
        ///convert data to list of flash card collections
        for(int i = 0; i < fisherData.length; i++){
          Map fccMap = fisherData[i];
          List<FlashCard> fcList = List.empty(growable: true);
          for(int j = 0; j < fccMap['c'].length; j++){
            fcList.add(FlashCard(term: fccMap['c'][j]['t'], definition: fccMap['c'][j]['d']));
          }
          collections.add(FlashCardCollection(title: fccMap['t'], collection: fcList));
        }
        collections.add(flashCardCollection);

        List jsonCollections = List.empty(growable: true);
        ///convert to json
        for(int i = 0; i < collections.length; i++){
          jsonCollections.add(collections[i].toJSON());
        }
        ///save data in file
        await fisherDataFile.writeAsString(jsonCollections.toString());
      }else{
        /// if there is no file, just save data in file
        collections.add(flashCardCollection.toJSON());
        await fisherDataFile.writeAsString(collections.toString());
      }

    }catch(e){
      print(e);
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
        for (int i = 0; i < fisherData.length; i++) {
          Map fccMap = fisherData[i];
          List<FlashCard> fcList = List.empty(growable: true);
          for (int j = 0; j < fccMap['c'].length; j++) {
            fcList.add(FlashCard(
                term: fccMap['c'][j]['t'], definition: fccMap['c'][j]['d']));
          }
          collections.add(FlashCardCollection(
              title: fccMap['t'], collection: fcList));
        }

        var indexToDelete = collections.indexWhere((element) => element.title == selectedCollection.title);
        if(collections[indexToDelete].collection.length == selectedCollection.collection.length) {
          collections.removeAt(indexToDelete);
        }

        List jsonCollections = List.empty(growable: true);
        ///convert to json
        for(int i = 0; i < collections.length; i++){
          jsonCollections.add(collections[i].toJSON());
        }
        ///save data in file
        await fisherDataFile.writeAsString(jsonCollections.toString());
      }
    }catch(e){
      print(e);
    }
  }
}