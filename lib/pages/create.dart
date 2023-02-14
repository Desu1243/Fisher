import 'package:flutter/material.dart';
import 'package:fisher/models/FlashCard.dart';
import 'package:fisher/models/FlashCardCollection.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {


  void addFormField(){

  }

  void sendForm(){

  }

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    var collectionListView = ListView(
      padding: const EdgeInsets.all(10),
    );

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        foregroundColor: theme.secondary,
        title: const Text('Create flash card collection'),
        elevation: 0,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.done_rounded))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.surface,
        child: Icon(Icons.add, size: 50, color: theme.background),
        onPressed: () => {

        },
      ),
      body: SafeArea(
        child: Column(
          children: [

            Container(
              color: theme.primary,

            )
          ],
        ),
      ),
    );
  }
}
