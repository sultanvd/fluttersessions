import 'dart:collection';

import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteWordsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FavoriteWordsWidgetState();
  }
}

class FavoriteWordsWidgetState extends State<FavoriteWordsWidget> {
  Map<String, bool> _suggestions = HashMap();
  final TextStyle _biggerFont = TextStyle(fontSize: 18.0);
  final String SHARED_PREF_KEY = "favorite_list";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Favorite"),
        ),
        body: _buildSuggestions());
  }

  Widget _buildSuggestions() {
    loadFavoriteItems();
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _suggestions.keys.length,
        itemBuilder: /*1*/ (context, i) {
          return _buildRow(_suggestions.keys.toList()[i]);
        });
  }

  Widget _buildRow(String word) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Padding(
                padding:
                    EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        word,
                        style: _biggerFont,
                      ),
                      Icon(
                        _suggestions[word]
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: _suggestions[word] ? Colors.red : null,
                      )
                    ],
                  ),
                  onTap: () => onFavoriteItemClicked(word),
                )),
            Divider()
          ],
        ));
  }

  onFavoriteItemClicked(String word) async {
    setState(() {
        removeWordPair(word);
    });
  }

  void removeWordPair(String word) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedList = prefs.getStringList(SHARED_PREF_KEY);

    if (savedList != null) {
      savedList.remove(word);
      await prefs.setStringList(SHARED_PREF_KEY, savedList);
      _suggestions.remove(word);
    }
  }

  void loadFavoriteItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedList = prefs.getStringList(SHARED_PREF_KEY);

    if (savedList != null) {
      Map<String, bool> newSuggestions = HashMap();
      savedList.forEach((savedWord) => {
        newSuggestions[savedWord] = true
      });

      setState(() {
        print("Setting state after updating values");
        _suggestions = newSuggestions;
      });
    }
  }
}
