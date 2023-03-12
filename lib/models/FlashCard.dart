import 'package:flutter/material.dart';

class FlashCard{
  late String term; //term user wants to learn
  late String definition; //definition (or translation) of that term
  bool toggle = true;

  FlashCard({
    required this.term,
    required this.definition
  });
}