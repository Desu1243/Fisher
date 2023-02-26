import 'package:flutter/material.dart';
import 'package:fisher/models/FlashCard.dart';
import 'package:fisher/models/FlashCardCollection.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {

  var listOfFields = <Widget>[];
  TextEditingController fieldController = TextEditingController();
  void addNewField(){
    setState((){
      listOfFields.add(TextFormField(controller: fieldController));
    });
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
          IconButton(onPressed: (){

          }, icon: const Icon(Icons.done_rounded))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.surface,
        onPressed: ()=>addNewField(),
        child: Icon(Icons.add, size: 50, color: theme.background),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
              key : formKey,
              child :Scaffold(
                  body : ListView.builder(
                      itemCount: listOfFields.length,
                      itemBuilder: (context, index){
                        return listOfFields[index];
                      }
                  ),
              ),
          ),
        ),
      ),
    );
  }
}
