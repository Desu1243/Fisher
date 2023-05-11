import 'dart:convert';

import 'package:fisher/models/FlashCard.dart';
import 'package:fisher/models/FlashCardCollection.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Collections{
  late List<FlashCardCollection> collectionList = List.empty(growable: true);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/fisherData.txt');
  }

  /// fetches data from database, creates db and tables if they don't exist
  Future<void> getData() async {
    var db = await openDatabase('fisher.db');
    await db.execute("CREATE TABLE IF NOT EXISTS collections (id integer primary key autoincrement, title TEXT NOT NULL)");
    await db.execute("CREATE TABLE IF NOT EXISTS flashcards (id integer primary key autoincrement, collection_id INT NOT NULL, term TEXT NOT NULL, definition TEXT NOT NULL, FOREIGN KEY (collection_id) REFERENCES collections(id))");

    List<Map> dbCollections = await db.rawQuery('SELECT * FROM collections');

    dbCollections.forEach((colItem) async {
      List<FlashCard> _collection = List.empty(growable: true);
      List<Map> dbCards = await db.rawQuery('SELECT * FROM flashcards WHERE collection_id="${colItem['id']}"');

      dbCards.forEach((card){
        _collection.add(FlashCard(term: card['term'], definition: card['definition']));
      });

      collectionList.add(FlashCardCollection(title: colItem['title'], collection: _collection, id: colItem['id']));
    });
    await Future.delayed(const Duration(milliseconds: 100),(){});
  }

/*
  /// saves flash card collection in database
  Future<void> saveCollection(FlashCardCollection flashCardCollection) async {
    var db = await openDatabase('fisher.db');

    await db.execute("CREATE TABLE IF NOT EXISTS collections (id integer primary key autoincrement, title TEXT NOT NULL)");
    await db.execute("CREATE TABLE IF NOT EXISTS flashcards (id integer primary key autoincrement, collection_id INT NOT NULL, term TEXT NOT NULL, definition TEXT NOT NULL, FOREIGN KEY (collection_id) REFERENCES collections(id))");

    List<Map> dbCollection = await db.rawQuery('SELECT * FROM collections');
    await db.insert(
        'collections',
        flashCardCollection.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
    dbCollection = await db.rawQuery('SELECT id FROM collections WHERE title="${flashCardCollection.title}"');
    flashCardCollection.collection.forEach((item) async {
        await db.insert(
            'flashcards',
            item.toMap(dbCollection[0]['id']),
            conflictAlgorithm: ConflictAlgorithm.replace
        );
    });
    await Future.delayed(const Duration(milliseconds: 50),(){});
  }
  */


  Future<void> deleteCollection(int collectionId) async {
    var db = await openDatabase('fisher.db');
    await db.execute('DELETE FROM collections WHERE id="$collectionId"');
    await db.execute('DELETE FROM flashcards WHERE collection_id="$collectionId"');
  }




  /// Gets data from fisherData.txt file and sets it as collectionList
  //Future<void> getData() async {}
  /// Saves

  Future<void> saveCollection(FlashCardCollection flashCardCollection) async {
    /// permission request, just in case
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();

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
          collections.add(FlashCardCollection(id: 0, title: fccMap['t'], collection: fcList));
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
  ///
  //Future<void> deleteCollection(int collectionId) async {}
}