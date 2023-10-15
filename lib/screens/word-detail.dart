import 'package:eng_uzb_dictionary/models/word.dart';
import 'package:flutter/material.dart';

class WordDetail extends StatelessWidget {
  const WordDetail({super.key, required this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(92, 185, 98, 1),
        title: Text(
          "Word Detials",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Color.fromRGBO(92, 185, 98, 1),
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                children: [
                  Text(word.english,
                      style: TextStyle(fontSize: 26, color: Colors.white)),
                  Text(word.type,
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
