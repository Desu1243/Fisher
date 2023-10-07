import 'dart:io';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:fisher/models/FlashCardCollection.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class ImportExport {
  late FlashCardCollection data;
  bool exportMessage = true;
  String? dataQR;

  getData() async {
    /// check for request permissions to manage files
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      //Permission.manageExternalStorage,
    ].request();

    /// open file selector
    FilePickerResult? selectedFile =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    if (selectedFile != null) {
      /// convert json from file to map
      File dataToImportJSON = File(selectedFile.files.first.path as String);

      /// convert map to FlashCardCollection object
      Map<String, dynamic> fileData =
          jsonDecode(dataToImportJSON.readAsStringSync());
      FlashCardCollection newCollection =
          FlashCardCollection.fromJson(fileData);

      /// set flash card collection as data
      data = newCollection;
    }
  }

  exportCollection(FlashCardCollection data) async {
    /// check for request permissions to manage files
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      //Permission.manageExternalStorage,
    ].request();

    var dataToExport = jsonEncode(data.toMap());

    /// select directory to save exported file in
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    /// save data in file if possible
    if (selectedDirectory != null) {
      try {
        File localFile = File("$selectedDirectory/${data.title}.txt");
        await localFile.writeAsString(dataToExport.toString());
      } catch (e) {
        exportMessage = false;
      }
    }
  }

  getDataQR() async {
    ///open scanner
    ///get json data from qr code
    ///try to decode it to collection
    ///set decoded collection as 'data' variable
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
    ].request();

    String scannedCode;
    try {
      scannedCode = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      FlashCardCollection dataFromQR = FlashCardCollection.fromJson(jsonDecode(scannedCode));
      data = dataFromQR;
    } catch (e) {
      print(e);
    }
  }

  exportCollectionQR(FlashCardCollection data) async {
    dataQR = null;

    ///convert given data to json
    String dataJson = jsonEncode(data.toMap());

    ///check if it has less than 2954 characters in length
    ///at max size QR code is big and hard to scan
    if (dataJson.length < 2954) {
      dataQR = dataJson;
    }
  }
}
