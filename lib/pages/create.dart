import 'package:flutter/material.dart';
import 'package:fisher/models/FlashCard.dart';
import 'package:fisher/models/FlashCardCollection.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  /*var listOfFields = <Widget>[];
  TextEditingController fieldController = TextEditingController();
  void addNewField(){
    setState((){
      listOfFields.add(TextFormField(controller: fieldController));
    });*/

  TextEditingController titleController = TextEditingController();

  void addFormField() {

  }

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        foregroundColor: theme.secondary,
        title: const Text('Create flash card collection'),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.done_rounded))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.surface,
        onPressed: () => {},
        child: Icon(Icons.add, size: 50, color: theme.background),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: TextFormField(
                controller: titleController,
                autofocus: true,
                cursorColor: theme.secondary,
                style: TextStyle(color: theme.secondary),
                decoration: InputDecoration(
                  focusColor: theme.secondary,
                  hintText: "Title",
                  hintStyle: TextStyle(color: theme.secondary),

                ),
              )
            ),
            Container(
              color: theme.primary,
            )
          ],
        ),
      ),
    );
  }
}
