import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(),
      bottomNavigationBar: Container(
        color: Colors.amber,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(icon: Icon(Icons.home_filled), iconSize: 48, onPressed: (){

            }),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
              child: VerticalDivider(width: 2.0, color: Colors.black, thickness: 2.0),
            ),
            IconButton(icon: Icon(Icons.add_circle), iconSize: 48, onPressed: (){

            }),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
              child: VerticalDivider(width: 2.0, color: Colors.black, thickness: 2.0),
            ),
            IconButton(icon: Icon(Icons.settings), iconSize: 48, onPressed: (){

            }),
          ],
        ),
      ),
    );
  }
}
