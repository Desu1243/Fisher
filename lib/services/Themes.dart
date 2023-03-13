import 'package:sqflite/sqflite.dart';

class Themes{
  late int themeId;

  Future<void> changeTheme(int number) async{
    var db = await openDatabase('fisher.db');
    int update = await db.rawUpdate(
    'UPDATE theme SET theme_number = $number WHERE id=1');
  }

  Future<void> getTheme() async{
    var db = await openDatabase('fisher.db');
    List<Map> dbThemes = await db.rawQuery('SELECT * FROM theme');
    this.themeId = dbThemes[0]['theme_number'];
  }
}