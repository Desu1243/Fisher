import 'package:fisher/services/Collections.dart';
import 'package:fisher/services/ImportExport.dart';
import 'package:flutter/material.dart';
import 'package:fisher/models/FlashCard.dart';
import 'package:fisher/models/FlashCardCollection.dart';
import 'package:fisher/widgets/FlashCardFormItemWidget.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class CreatePage extends StatefulWidget {
  final FlashCardCollection data;
  final bool editMode;

  CreatePage({super.key, required this.data, required this.editMode});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  late FlashCardCollection data;
  TextEditingController titleController = TextEditingController();
  ScrollController formScrollController = ScrollController();
  List<FlashCardFormItemWidget> flashCardForms = List.empty(growable: true);
  ImportExport import = ImportExport();

  @override
  void initState() {
    data = widget.data;
    titleController.text = data.title;
    for(int i=0; i< data.collection.length; i++){
      flashCardForms.add(FlashCardFormItemWidget(flashCard: data.collection[i]));
    }
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
        title: Text( widget.editMode? 'Edit collection': 'Create collection',
          style: const TextStyle(fontSize: 18),
        ),
        elevation: 0,
        actions: [
          /// import collection using camera scanned QR code
          IconButton(
              onPressed: () async {
                ///get data from importIcon
                await import.getDataQR();
                importCollection(import.data);
              },
              icon: const Icon(Icons.qr_code_scanner_outlined)),
          /// import flash card collection
          IconButton(
              onPressed: () async {
                ///get data from importIcon
                await import.getData();
                importCollection(import.data);
              },
              icon: const Icon(Icons.download_rounded)),
        /// save flash card collection
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

  /// saves or updates flash card collection in database depending on the mode
  onSaveForm() async {
    List<FlashCard> _flashCards = List.empty(growable: true);
    Collections collectionsService = Collections();
    if(widget.editMode) {
      /// delete previous collection
      await collectionsService.deleteCollection(data);
    }

    /// save new collection
    flashCardForms.forEach((fc) {
      _flashCards.add(FlashCard(
          term: fc.flashCard.term, definition: fc.flashCard.definition));
    });
    if (titleController.text.isNotEmpty) {
      FlashCardCollection flashCardCollection = FlashCardCollection(
          title: titleController.text, collection: _flashCards);

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

  importCollection(FlashCardCollection data){
    setState(() {
      titleController.text = data.title;
      flashCardForms = List.empty(growable: true);
      for(int i=0; i< data.collection.length; i++){
        flashCardForms.add(FlashCardFormItemWidget(flashCard: data.collection[i]));
      }
    });
  }
}
