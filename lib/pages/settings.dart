import 'package:fisher/services/Themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class Settings extends StatefulWidget {
  late int themeId;
  Settings({super.key, required this.themeId});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    Themes themeService = Themes();

    return Scaffold(
      backgroundColor: theme.onPrimary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.background,
        foregroundColor: theme.secondary,
        title: const Text('Settings'),
        actions: [
          IconButton(
              onPressed: () {
                Phoenix.rebirth(context);
              },
              icon: const Icon(Icons.done_rounded))
        ],
      ),
      body: Column(
        children: [
          ExpansionTile(
            textColor: theme.secondary,
            collapsedTextColor: theme.secondary,
            iconColor: theme.secondary,
            collapsedIconColor: theme.secondary,
            backgroundColor: theme.primary,
            collapsedBackgroundColor: theme.primary,
            title: const Row(children:  [
              Icon(Icons.palette_outlined),
              SizedBox(width: 8.0),
              Text('Theme')
            ]),
            children: [
              ListTile(
                title: const Text('Forest green'),
                textColor: theme.secondary,
                leading: Radio<int>(
                  activeColor: theme.secondary,
                  focusColor: theme.secondary,
                  fillColor: MaterialStatePropertyAll(theme.secondary),
                  value: 0,
                  groupValue: widget.themeId,
                  onChanged: (value) {
                    setState(() {
                      widget.themeId = value!;
                      themeService.changeTheme(widget.themeId);
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Purple haze'),
                textColor: theme.secondary,
                leading: Radio<int>(
                  activeColor: theme.secondary,
                  focusColor: theme.secondary,
                  fillColor: MaterialStatePropertyAll(theme.secondary),
                  value: 1,
                  groupValue: widget.themeId,
                  onChanged: (value) {
                    setState(() {
                      widget.themeId = value!;
                      themeService.changeTheme(widget.themeId);
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Deep blue ocean'),
                textColor: theme.secondary,
                leading: Radio<int>(
                  activeColor: theme.secondary,
                  focusColor: theme.secondary,
                  fillColor: MaterialStatePropertyAll(theme.secondary),
                  value: 2,
                  groupValue: widget.themeId,
                  onChanged: (value) {
                    setState(() {
                      widget.themeId = value!;
                      themeService.changeTheme(widget.themeId);
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
