import 'package:flutter/material.dart';

class FlashCard{
  late String term; //term user wants to learn
  late String definition; //definition (or translation) of that term
  bool toggle = true;

  TextEditingController termController = TextEditingController();
  TextEditingController definitionController = TextEditingController();

  late ColorScheme theme;

  FlashCard({
    required this.term,
    required this.definition
  });

  Widget formField(theme){
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextFormField(
            controller: termController,
          ),
          TextFormField(
            controller: definitionController,
          )
        ],
      ),
    );
  }
}