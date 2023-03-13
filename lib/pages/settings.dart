import 'package:fisher/services/Themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  final int themeId;
  const Settings({super.key, required this.themeId});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    int? selectedTheme = widget.themeId;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.background,
        foregroundColor: theme.secondary,
        title: const Text('Settings'),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.done_rounded))
        ],
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: const Text('Forest green'),
            leading: Radio<int>(
              value: 0,
              groupValue: selectedTheme,
              onChanged: (value) {
                setState(() {
                  selectedTheme = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Blue sky'),
            leading: Radio<int>(
              value: 1,
              groupValue: selectedTheme,
              onChanged: (value) {
                setState(() {
                  selectedTheme = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
