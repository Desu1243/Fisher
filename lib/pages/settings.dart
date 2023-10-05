import 'package:fisher/services/Languages.dart';
import 'package:fisher/services/Themes.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

class Settings extends StatefulWidget {
  late int themeId;
  late int langId = Lang.langId;
  Settings({super.key, required this.themeId});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    Map<String, String> language = Lang.languages[Lang.langId];

    return Scaffold(
      backgroundColor: theme.onPrimary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.background,
        foregroundColor: theme.secondary,
        title: Text(language['settings.title']!),
        actions: [
          IconButton(
              onPressed: () {
                Restart.restartApp();
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
            title: Row(children: [
              Icon(Icons.palette_outlined),
              SizedBox(width: 8.0),
              Text(language['settings.theme']!)
            ]),
            children: [
              ListTile(
                title: Text(language['settings.themeFG']!),
                textColor: theme.secondary,
                leading: Radio<int>(
                  activeColor: theme.secondary,
                  focusColor: theme.secondary,
                  fillColor: MaterialStatePropertyAll(theme.secondary),
                  value: 0,
                  groupValue: widget.themeId,
                  onChanged: (value) {
                    changeTheme(value);
                  },
                ),
              ),
              ListTile(
                title: Text(language['settings.themePH']!),
                textColor: theme.secondary,
                leading: Radio<int>(
                  activeColor: theme.secondary,
                  focusColor: theme.secondary,
                  fillColor: MaterialStatePropertyAll(theme.secondary),
                  value: 1,
                  groupValue: widget.themeId,
                  onChanged: (value) {
                    changeTheme(value);
                  },
                ),
              ),
              ListTile(
                title: Text(language['settings.themeDBO']!),
                textColor: theme.secondary,
                leading: Radio<int>(
                  activeColor: theme.secondary,
                  focusColor: theme.secondary,
                  fillColor: MaterialStatePropertyAll(theme.secondary),
                  value: 2,
                  groupValue: widget.themeId,
                  onChanged: (value) {
                    changeTheme(value);
                  },
                ),
              ),
              ListTile(
                title: Text(language['settings.change']!),
                textColor: theme.secondary
              ),
            ],
          ),
          ExpansionTile(
            textColor: theme.secondary,
            collapsedTextColor: theme.secondary,
            iconColor: theme.secondary,
            collapsedIconColor: theme.secondary,
            backgroundColor: theme.primary,
            collapsedBackgroundColor: theme.primary,
            title: Row(children: [
              Icon(Icons.language_outlined),
              SizedBox(width: 8.0),
              Text(language['settings.language']!)
            ]),
            children: [
              ListTile(
                title: const Text('English'),
                textColor: theme.secondary,
                leading: Radio<int>(
                  activeColor: theme.secondary,
                  focusColor: theme.secondary,
                  fillColor: MaterialStatePropertyAll(theme.secondary),
                  value: 0,
                  groupValue: widget.langId,
                  onChanged: (value) {
                    changeLanguage(value);
                  },
                ),
              ),
              ListTile(
                title: const Text('Polski'),
                textColor: theme.secondary,
                leading: Radio<int>(
                  activeColor: theme.secondary,
                  focusColor: theme.secondary,
                  fillColor: MaterialStatePropertyAll(theme.secondary),
                  value: 1,
                  groupValue: widget.langId,
                  onChanged: (value) {
                    changeLanguage(value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  changeTheme(value){
    Themes themeService = Themes();
    setState(() {
      widget.themeId = value!;
      themeService.changeTheme(widget.themeId);
    });
  }

  changeLanguage(value){
    Lang languagesService = Lang();
    setState(() {
      widget.langId = value!;
      languagesService.changeLang(widget.langId);
    });
  }
}
