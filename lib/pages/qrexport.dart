import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRExportPage extends StatelessWidget {
  final String collectionTitle;
  final String codeData;

  const QRExportPage({super.key, required this.collectionTitle, required this.codeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(collectionTitle),
        centerTitle: true,
      ),
      body: Center(
        child: QrImage(
          data: codeData,
          embeddedImageStyle: QrEmbeddedImageStyle(),
        ),
      ),
    );
  }
}
