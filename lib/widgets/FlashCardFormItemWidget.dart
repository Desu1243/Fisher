import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fisher/models/FlashCard.dart';
import 'package:fisher/services/Languages.dart';
import '../services/Themes.dart';


class FlashCardFormItemWidget extends StatefulWidget {
  FlashCard flashCard;
  final TextEditingController _termController = TextEditingController();
  final TextEditingController _definitionController = TextEditingController();

  FlashCardFormItemWidget({super.key, required this.flashCard}){
    _termController.text = flashCard.term;
    _definitionController.text = flashCard.definition;
  }

  @override
  State<StatefulWidget> createState() => _FlashCardFormItemWidgetState();
}

class _FlashCardFormItemWidgetState extends State<FlashCardFormItemWidget> {
  final formKey = GlobalKey<FormState>();
  Map<String, String> language = Lang.languages[Lang.langId];

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Themes.themes[Themes.themeId];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          color: theme.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: widget._termController,
                onChanged: (value) => widget.flashCard.term = value,
                onSaved: (value) => widget.flashCard.term = value!,
                style: TextStyle(color: theme.secondary, fontSize: 20),
                cursorColor: theme.secondary,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.surface),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.secondary),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(language['flashCardForm.term']!, style: TextStyle(color: theme.secondary)),
              ),

              TextFormField(
                controller: widget._definitionController,
                onChanged: (value) => widget.flashCard.definition = value,
                onSaved: (value) => widget.flashCard.definition = value!,
                style: TextStyle(color: theme.secondary, fontSize: 20),
                cursorColor: theme.secondary,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.surface),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.secondary),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(language['flashCardForm.definition']!, style: TextStyle(color: theme.secondary)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
