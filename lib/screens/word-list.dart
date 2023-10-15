import 'dart:async';

import 'package:eng_uzb_dictionary/api/word-dao.dart';
import 'package:eng_uzb_dictionary/models/word.dart';
import 'package:eng_uzb_dictionary/screens/word-detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WordsList extends StatefulWidget {
  @override
  State<WordsList> createState() => _WordsList();
}

class _WordsList extends State<WordsList> {
  bool isSearching = false;
  String searchWord = "";

  @override
  void initState() {
    super.initState();
  }

  Future<List<Word>> getAllWord() async {
    var list = await WordsDao().getAllWords();
    return list;
  }

  Future<List<Word>> search(String search) async {
    var list = await WordsDao().searchWord(search);
    return list;
  }

  Future<void> addToSaved(Word word) async {
    var fido = Word(
      id: word.id,
      english: word.english,
      type: word.type,
      transcript: word.transcript,
      uzbek: word.uzbek,
      countable: word.countable,
      is_favourite: word.is_favourite == 1 ? 0 : 1,
      is_favourite_uzb: word.is_favourite_uzb,
    );
    await WordsDao().updateWord(fido);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          color: Color.fromRGBO(92, 185, 98, 1),
          child: Card(
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.only(left: 16, top: 5, right: 16, bottom: 5),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.headset_mic_rounded,
                        color: Color.fromRGBO(200, 201, 201, 1)),
                    icon: Icon(Icons.search,
                        color: Color.fromRGBO(200, 201, 201, 1))),
                onChanged: (searchResult) {
                  print(searchResult);
                  if (searchWord.isEmpty) {
                    setState(() {
                      isSearching = false;
                      searchWord = searchResult;
                    });
                  } else {
                    setState(() {
                      searchWord = "";
                      isSearching = true;
                    });
                  }
                },
              ),
            ),
          ),
        ),
        Expanded(
            child: FutureBuilder<List<Word>>(
          future: isSearching ? search(searchWord) : getAllWord(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var list = snapshot.data;
              return ListView.builder(
                itemCount: list!.length,
                itemBuilder: (context, i) {
                  var word = list[i];
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WordDetail(word: word),
                          ),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16, top: 5, right: 16, bottom: 5),
                          child: ListTile(
                              leading: Icon(Icons.light_mode,
                                  color: Color.fromRGBO(92, 185, 98, 1)),
                              title: Text(
                                "${word.english}",
                                style: TextStyle(fontSize: 18),
                              ),
                              subtitle: Text(
                                "[ ${word.transcript} ]",
                                style: TextStyle(
                                    fontSize: 16, fontStyle: FontStyle.italic),
                              ),
                              trailing: IconButton(
                                icon: word.is_favourite == 1
                                    ? Icon(Icons.bookmark,
                                        color: Color.fromRGBO(92, 185, 98, 1))
                                    : Icon(Icons.bookmark_outline,
                                        color: Color.fromRGBO(92, 185, 98, 1)),
                                onPressed: () => addToSaved(word),
                              )),
                        ),
                      ));
                },
              );
            } else {
              return Center();
            }
          },
        ))
      ]),
    );
  }
}
