import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Lang{
  static late int langId;
  static late Map<String,String> lang;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/fisherLang.txt');
  }

  Future<void> changeLang(int number) async{
    try {
      final fisherLangFile = await _localFile;
      fisherLangFile.writeAsStringSync('$number');
    }catch(e){
      langId = 0;
      lang = languages[langId];
    }
  }

  Future<void> getLang() async{
    try {
      final fisherThemeFile = await _localFile;
      if(await fisherThemeFile.exists()){
        var themeFileContent = await fisherThemeFile.readAsString();
        langId = int.parse(themeFileContent);
      }else{
        langId = 0;
        fisherThemeFile.writeAsStringSync('0');
      }
      lang = languages[langId];
    }catch(e){
      langId = 0;
      lang = languages[langId];
    }
  }

  static List<Map<String, String>> languages = [
    //english
    {
      'language':'English',
      'home.add':'Click on the plus sign at the bottom to create your first flash card collection.',
      'create.create':'Create collection',
      'create.edit':'Edit collection',
      'create.title':'TITLE',
      'flashCardForm.term':'TERM',
      'flashCardForm.definition':'DEFINITION',
      'cards.term':'term',
      'cards.terms':'terms',
      'cards.qrTooLong':'Collection is too long',
      'cards.qrExportSuccess':'Collection successfully exported',
      'cards.qrExportFail':'Something went wrong',
      'cards.learnFlashCards':'Learn using flash cards',
      'cards.learnTermsDef':'Learn terms and definitions',
      'cards.flashCards':'Flash cards',
      'learning.known':'Known terms',
      'learning.unknown':'Unknown terms',
      'learning.goodJob':'Good job! Just keep learning!',
      'settings.title':'Settings',
      'settings.theme':'Theme',
      'settings.themeFG':'Forest green',
      'settings.themePH':'Purple haze',
      'settings.themeDBO':'Deep blue ocean',
      'settings.language':'Language',
      'delete.title':'Delete collection?',
      'delete.notification':'You are about to delete this flash card collection. Are you sure?',
      'delete.no':'No',
      'delete.yes':'Yes',
    },
    //polish
    {
      'language':'Polski',
      'home.add':'Brak kolekcji',
      'create.create':'Stwórz kolekcję',
      'create.edit':'Edytuj kolekcję',
      'create.title':'TYTUŁ',
      'flashCardForm.term':'TERMIN',
      'flashCardForm.definition':'DEFINICJA',
      'cards.term':'termin',
      'cards.terms':'terminów',
      'cards.qrTooLong':'Kolekcja jest zbyt duża',
      'cards.qrExportSuccess':'Kolekcja została wyeksportowana',
      'cards.qrExportFail':'Coś poszło nie tak',
      'cards.learnFlashCards':'Fiszki',
      'cards.learnTermsDef':'Terminy i definicje',
      'cards.flashCards':'Fiszki',
      'learning.known':'Znane terminy',
      'learning.unknown':'Nieznane terminy',
      'learning.goodJob':'Swietna robota! Oby tak dalej!',
      'settings.title':'Ustawienia',
      'settings.theme':'Motyw',
      'settings.themeFG':'Leśna zieleń',
      'settings.themePH':'Fioletowa mgła',
      'settings.themeDBO':'Głęboki ocean',
      'settings.language':'Język',
      'delete.title':'Usunąć kolekcje?',
      'delete.notification':'Zaraz usuniesz kolekcję fiszek. Czy na pewno chcesz to zrobić?',
      'delete.no':'Nie',
      'delete.yes':'Tak',
    },
  ];
}