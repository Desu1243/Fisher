import 'package:fisher/models/FlashCard.dart';
import 'package:fisher/models/FlashCardCollection.dart';
import 'package:sqflite/sqflite.dart';

class Collections{
  late List<FlashCardCollection> collectionList = [];

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

    await Future.delayed(const Duration(milliseconds: 300),(){});
  }

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
  }

  Future<void> deleteCollection(int collectionId) async {
    var db = await openDatabase('fisher.db');
    await db.execute('DELETE FROM collections WHERE id="$collectionId"');
  }
}