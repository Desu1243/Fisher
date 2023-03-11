import 'package:sqflite/sqflite.dart';

class Themes{

  Future<void> changeTheme(int number) async{
  var db = await openDatabase('fisher.db');
  int update = await db.rawUpdate(
  'UPDATE theme SET theme_number = $number WHERE id=1');
  }
}