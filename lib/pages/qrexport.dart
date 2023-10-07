import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../services/Themes.dart';

class QRExportPage extends StatelessWidget {
  final String collectionTitle;
  final String codeData;

  const QRExportPage({super.key, required this.collectionTitle, required this.codeData});

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Themes.themes[Themes.themeId];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.background,
        foregroundColor: theme.secondary,
        elevation: 0,
        title: Text(collectionTitle),
        centerTitle: true,
      ),
      body: Center(
        child: QrImage(
          data: codeData,
          errorCorrectionLevel: QrErrorCorrectLevel.L,
        ),
      ),
    );
  }
}
