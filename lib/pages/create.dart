import 'package:fisher/services/Collections.dart';
import 'package:flutter/material.dart';
import 'package:fisher/models/FlashCard.dart';
import 'package:fisher/models/FlashCardCollection.dart';
import 'package:fisher/widgets/FlashCardFormItemWidget.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController titleController = TextEditingController();
  List<FlashCardFormItemWidget> flashCardForms = List.empty(growable: true);
  ScrollController formScrollController = ScrollController();

  @override
  void initState() {
    onAddFormField();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    bool visibleKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: theme.background,
      appBar: AppBar(
        foregroundColor: theme.secondary,
        title: const Text(
          'Create flash card collection',
          style: TextStyle(fontSize: 18),
        ),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                onSaveForm();
              },
              icon: const Icon(Icons.done_rounded))
        ],
      ),
      floatingActionButton: Opacity(
        opacity: visibleKeyboard ? 0.5 : 1,
        child: FloatingActionButton(
          backgroundColor: theme.surface,
          onPressed: () => {
            onAddFormField(),
          },
          child: Icon(Icons.add, size: 50, color: theme.background),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: TextFormField(
                  controller: titleController,
                  autofocus: false,
                  cursorColor: theme.secondary,
                  style: TextStyle(color: theme.secondary, fontSize: 20),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.surface),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.secondary),
                    ),
                  ),
                )),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              child: Text("TITLE", style: TextStyle(color: theme.secondary)),
            ),
            Expanded(
              child: ListView.builder(
                controller: formScrollController,
                itemCount: flashCardForms.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return flashCardForms[index];
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  /// saves flash card collection in database
  onSaveForm() async {
    List<FlashCard> _flashCards = List.empty(growable: true);
    Collections collectionsService = Collections();
    flashCardForms.forEach((fc) {
      _flashCards.add(FlashCard(
          term: fc.flashCard.term, definition: fc.flashCard.definition));
    });
    if (titleController.text.isNotEmpty) {
      FlashCardCollection flashCardCollection = FlashCardCollection(
          title: titleController.text, collection: _flashCards, id: 0);

      flashCardCollection.collection
          .removeWhere((fc) => fc.definition == "" || fc.term == "");
      if (flashCardCollection.collection.isNotEmpty) {
        collectionsService.saveCollection(flashCardCollection);
      }
    }
    await Future.delayed(const Duration(milliseconds: 50),(){});
    Phoenix.rebirth(context);
  }

  /// adds new form field to the form
  onAddFormField() {
    setState(() {
      FlashCard flashCard = FlashCard(term: "", definition: "");
      flashCardForms.add(FlashCardFormItemWidget(flashCard: flashCard));
    });
    if(flashCardForms.length > 1) {
      formScrollController.animateTo(
          formScrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300));
    }
  }
}
