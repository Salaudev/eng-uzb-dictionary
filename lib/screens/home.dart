import 'package:eng_uzb_dictionary/api/word-dao.dart';
import 'package:eng_uzb_dictionary/models/word.dart';
import 'package:eng_uzb_dictionary/screens/cards.dart';
import 'package:eng_uzb_dictionary/screens/saved.dart';
import 'package:eng_uzb_dictionary/screens/word-detail.dart';
import 'package:eng_uzb_dictionary/screens/word-list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  bool isSearching = false;
  String searchWord = "";

  void onBottomIconTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(93, 185, 98, 1),
        elevation: 0.0,
        title: Text('Salau Dictionary',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            )),
        centerTitle: true,
      ),
      body: PageView(
          controller: pageController, children: [WordsList(), SavedWords(), Cards()]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
        ],
        selectedItemColor: Color.fromRGBO(93, 185, 98, 1),
        unselectedItemColor: Color.fromRGBO(168, 168, 168, 1),
        currentIndex: _selectedIndex,
        onTap: onBottomIconTap,
      ),
    );
  }
}
