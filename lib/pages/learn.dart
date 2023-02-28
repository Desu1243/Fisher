import 'package:fisher/models/FlashCard.dart';
import 'package:fisher/models/LearningProgress.dart';
import 'package:flutter/material.dart';
import '../models/FlashCardCollection.dart';
import 'package:pie_chart/pie_chart.dart';

class LearnPage extends StatefulWidget {
  final FlashCardCollection flashCardCollection;

  const LearnPage({super.key, required this.flashCardCollection});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  LearningProgress lp = LearningProgress();
  List<FlashCard> shuffledCollection = List.empty();

  @override
  void initState() {
    shuffledCollection = [...widget.flashCardCollection.collection];
    shuffledCollection.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    List<FlashCard> collection = widget.flashCardCollection.collection;

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.background,
        foregroundColor: theme.secondary,
        title: Text("${lp.progress + 1}/${collection.length}"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          /// score bar
          if (!lp.doneLearning)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: theme.error),
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Text(lp.unknownTerms.toString(),
                      style: TextStyle(color: theme.error, fontSize: 18)),
                ),
                Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: theme.surface),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10))),
                  child: Text(lp.knownTerms.toString(),
                      style: TextStyle(color: theme.surface, fontSize: 18)),
                )
              ],
            ),

          /// flash card
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: GestureDetector(
                onTap: () => {
                      shuffledCollection[lp.progress].toggle =
                          !shuffledCollection[lp.progress].toggle,
                      setState(() => {})
                    },
                child: LearnCard(
                  card: shuffledCollection[lp.progress],
                  learningProgress: lp,
                )),
          ))
        ],
      ),

      /// buttons :D
      bottomNavigationBar: Row(
        children: [
          if (!lp.doneLearning)
            Expanded(
              /// don't know button :(
              child: ElevatedButton(
                  onPressed: () => {
                        if (!lp.doneLearning)
                          {
                            if (lp.progress + 1 < shuffledCollection.length)
                              {lp.progress++, lp.unknownTerms++}
                            else
                              {lp.unknownTerms++, lp.doneLearning = true},
                          },
                        setState(() {})
                      },
                  style: ButtonStyle(
                    shape: const MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50)))),
                    backgroundColor: MaterialStateProperty.all(theme.error),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(Icons.clear_rounded,
                        color: theme.background, size: 50),
                  )),
            ),
          if (!lp.doneLearning)
            Expanded(
              /// know button :)
              child: ElevatedButton(
                  onPressed: () => {
                        if (!lp.doneLearning)
                          {
                            if (lp.progress + 1 < shuffledCollection.length)
                              {lp.progress++, lp.knownTerms++}
                            else
                              {lp.knownTerms++, lp.doneLearning = true},
                          },
                        setState(() {})
                      },
                  style: ButtonStyle(
                    shape: const MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50)))),
                    backgroundColor: MaterialStateProperty.all(theme.surface),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(Icons.check_rounded,
                        color: theme.background, size: 50),
                  )),
            )
        ],
      ),
    );
  }
}

class LearnCard extends StatelessWidget {
  final FlashCard card;
  final LearningProgress learningProgress;
  const LearnCard(
      {super.key, required this.card, required this.learningProgress});

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    if (!learningProgress.doneLearning) {
      return Card(
        color: theme.primary,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Center(
          child: Text(card.toggle ? card.term : card.definition,
              style: TextStyle(color: theme.secondary)),
        ),
      );
    } else {
      int sum = learningProgress.knownTerms + learningProgress.unknownTerms;
      int knownPercent = 0;
      Map<String, double> dataMap = {
        "Known terms": learningProgress.knownTerms.toDouble(),
        "Unknown terms": learningProgress.unknownTerms.toDouble(),
      };

      if (learningProgress.knownTerms == sum) {
        knownPercent = 100;
      } else {
        knownPercent = (learningProgress.knownTerms / sum * 100).toInt();
      }

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text("Excellent job, just keep learning",
                style: TextStyle(color: theme.secondary, fontSize: 24)),
          ),
          Row(
            children: [
              /// circle chart with percent
              SizedBox(
                width: 137,
                height: 137,
                child: Stack(
                  children: [
                    PieChart(
                      dataMap: dataMap,
                      chartType: ChartType.ring,
                      chartRadius: 120,
                      legendOptions: const LegendOptions(
                        showLegendsInRow: false,
                        legendPosition: LegendPosition.right,
                        showLegends: false,
                      ),
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValues: false,
                      ),
                      colorList: [theme.surface, theme.error],
                    ),
                    Center(
                        child: Text(
                      "$knownPercent%",
                      style: TextStyle(color: theme.secondary, fontSize: 24),
                    ))
                  ],
                ),
              ),

              ///
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Known terms: ${learningProgress.knownTerms}",
                      style: TextStyle(color: theme.surface, fontSize: 20),
                    ),
                    Text(
                      "Unknown terms: ${learningProgress.unknownTerms}",
                      style: TextStyle(
                        color: theme.error,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          ElevatedButton(
            onPressed: () => {
              Navigator.pop(context),
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(theme.primary),
            ),
            child: Text(
              "Nice",
              style: TextStyle(color: theme.secondary),
            ),
          )
        ],
      );
    }
  }
}
