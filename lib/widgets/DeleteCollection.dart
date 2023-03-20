import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../services/Collections.dart';

class DeleteCollection extends StatelessWidget {
  final int collectionId;
  const DeleteCollection({super.key, required this.collectionId});

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    return IconButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            backgroundColor: theme.background,
            title: Text('Delete collection?',
                style: TextStyle(color: theme.secondary)),
            content: Text(
                'You are about to delete this flash card collection. Are you sure?',
                style: TextStyle(color: theme.secondary)),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  /// remove collection from database
                  Collections instance = Collections();
                  await instance.deleteCollection(collectionId);
                  Phoenix.rebirth(context);
                },
                child:
                Text('Yes', style: TextStyle(color: theme.onSurface)),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: Text('No', style: TextStyle(color: theme.onError)),
              ),
            ],
          ),
        ),
        icon: const Icon(Icons.delete_rounded));
  }
}
