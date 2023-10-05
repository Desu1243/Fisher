import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../models/FlashCard.dart';
import '../services/Languages.dart';
import '../services/Learning.dart';

class LearningFlashCard extends StatelessWidget {
  final FlashCard card;
  final Learning learning;
  const LearningFlashCard(
      {super.key, required this.card, required this.learning});

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    Map<String, String> language = Lang.languages[Lang.langId];

    if (!learning.doneLearning) {
      /// flash card
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Card(
          color: theme.primary,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(card.toggle ? card.term : card.definition,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: theme.secondary, fontSize: 20)),
            ),
          ),
        ),
      );
    } else {
      int sum = learning.knownTerms + learning.unknownTerms;
      int knownPercent = 0;
      Map<String, double> dataMap = {
        "Unknown terms": learning.unknownTerms.toDouble(),
        "Known terms": learning.knownTerms.toDouble(),
      };

      if (learning.knownTerms == sum) {
        knownPercent = 100;
      } else {
        knownPercent = (learning.knownTerms / sum * 100).toInt();
      }

      /// learning summary
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(language['learning.goodJob']!,
                    style: TextStyle(color: theme.secondary, fontSize: 24)),
              ),
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
                        colorList: [theme.onError, theme.onSurface],
                      ),
                      Center(
                          child: Text(
                            "$knownPercent%",
                            style: TextStyle(color: theme.secondary, fontSize: 24),
                          ))
                    ],
                  ),
                ),

                /// progress summary
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${language['learning.known']!}: ${learning.knownTerms}",
                        style: TextStyle(color: theme.onSurface, fontSize: 20),
                      ),
                      Text(
                        "${language['learning.unknown']!}: ${learning.unknownTerms}",
                        style: TextStyle(
                          color: theme.onError,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),

            /// unknown terms divider label
            if(learning.unKnownTermsList.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(height: 1, color: theme.primary, thickness: 1),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text("${language['learning.unknown']!}:", style: TextStyle(color: theme.secondary, fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.start,),
                    ),
                    Divider(height: 1, color: theme.primary, thickness: 1),
                  ],
                ),
              ),

            /// ListView with unknown terms
            Expanded(
              child: ListView.builder(
                itemCount: learning.unKnownTermsList.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) => Card(
                  color: theme.primary,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(learning.unKnownTermsList[index].term,
                            style: TextStyle(color: theme.secondary, fontSize: 18)),
                        Divider(
                          height: 15,
                          color: theme.primary,
                        ),
                        Text(learning.unKnownTermsList[index].definition,
                            style: TextStyle(color: theme.secondary, fontSize: 18)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}