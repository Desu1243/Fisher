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

  List<FlashCard> listOfFields = List<FlashCard>.empty();

  TextEditingController titleController = TextEditingController();

  void addFormField() {}

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    //List<FlashCard> listOfFields;

    //final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        foregroundColor: theme.secondary,
        title: const Text(
          'Create flash card collection',
          style: TextStyle(fontSize: 18),
        ),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.done_rounded))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.surface,
        onPressed: () => {
            listOfFields.add(FlashCard(term: "", definition: "")),
          setState(() {
          })
        },

        child: Icon(Icons.add, size: 50, color: theme.background),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: titleController,
                  autofocus: false,
                  cursorColor: theme.secondary,
                  style: TextStyle(color: theme.secondary),
                  decoration: InputDecoration(
                    focusColor: theme.secondary,
                    hintText: "Title",
                    hintStyle: TextStyle(color: theme.secondary),
                  ),
                )),
            Container(
              color: theme.primary,
              child: ListView.builder(
                itemCount: listOfFields.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    FlashCard(term: "", definition: "").formField(theme),
              ),
            )
          ],
        ),
      ),
    );
  }
}
