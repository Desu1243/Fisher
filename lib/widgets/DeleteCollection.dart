import 'package:fisher/models/FlashCardCollection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../services/Collections.dart';
import '../services/Languages.dart';

class DeleteCollection extends StatelessWidget {
  final FlashCardCollection selectedCollection;
  const DeleteCollection({super.key, required this.selectedCollection});

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    Map<String, String> language = Lang.languages[Lang.langId];

    return IconButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            backgroundColor: theme.background,
            title: Text(language['delete.title']!,
                style: TextStyle(color: theme.secondary)),
            content: Text(
                language['delete.notification']!,
                style: TextStyle(color: theme.secondary)),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: Text(language['delete.no']!, style: TextStyle(color: theme.onError)),
              ),
              TextButton(
                onPressed: () async {
                  /// remove collection from database
                  Collections instance = Collections();
                  await instance.deleteCollection(selectedCollection);
                  Phoenix.rebirth(context);
                },
                child:
                Text(language['delete.yes']!, style: TextStyle(color: theme.onSurface)),
              ),

            ],
          ),
        ),
        icon: const Icon(Icons.delete_rounded));
  }
}
