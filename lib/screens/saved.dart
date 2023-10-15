import 'package:eng_uzb_dictionary/api/word-dao.dart';
import 'package:eng_uzb_dictionary/models/word.dart';
import 'package:flutter/material.dart';

class SavedWords extends StatefulWidget {
  const SavedWords({super.key});

  @override
  State<SavedWords> createState() => _HomePageState();
}

class _HomePageState extends State<SavedWords> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<Word>> getSavedWords() async {
    var list = await WordsDao().getSavedWords();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Word>>(
      future: getSavedWords(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var list = snapshot.data;
          return ListView.builder(
              itemCount: list!.length,
              itemBuilder: (context, i) {
                var word = list[i];
                return Card(
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
                              style: TextStyle(fontSize: 16),
                            ),
                            trailing: IconButton(
                              icon: word.is_favourite == 1
                                  ? Icon(Icons.bookmark,
                                      color: Color.fromRGBO(92, 185, 98, 1))
                                  : Icon(Icons.bookmark_outline,
                                      color: Color.fromRGBO(92, 185, 98, 1)),
                              onPressed: () => print("Bookmark pressed"),
                            ))));
              });
        } else {
          return Center();
        }
      },
    ));
  }
}
