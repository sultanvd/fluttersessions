import 'dart:collection';

import 'package:assignment5/widgets/FavoriteWordsWidget.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RandomWordsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RandomeWordsWidgetState();
  }
}

class RandomeWordsWidgetState extends State<RandomWordsWidget> {
  Map<String, bool> _suggestions = HashMap();
  final TextStyle _biggerFont = TextStyle(fontSize: 18.0);
  final String SHARED_PREF_KEY = "favorite_list";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Name Generator"),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20),
                child: InkWell(
                    child: Icon(Icons.list),
                    onTap: () => {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      FavoriteWordsWidget()))
                              .whenComplete(() => {updateFavoriteInMemory()})
                        }))
          ],
        ),
        body: _buildSuggestions());
  }

  Widget _buildSuggestions() {
    print("Building row");

    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i >= _suggestions.keys.length) {
            generateWordPairs().take(10).forEach(
                (value) => _suggestions[value.asPascalCase] = false /*4*/
                );

            updateFavoriteInMemory();
          }

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
                  onTap: () => onFavoriteClicked(word),
                )),
            Divider()
          ],
        ));
  }

  onFavoriteClicked(String word) async {
    bool saved = await isSaved(word);
    setState(() {
      if (!saved) {
        saveWordPair(word);
      } else {
        removeWordPair(word);
      }
    });
  }

  Future<bool> isSaved(String word) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedList = prefs.getStringList(SHARED_PREF_KEY);

    int index = -1;
    if (savedList != null) {
      index = savedList.indexOf(word);
    }
    return index != -1;
  }

  void saveWordPair(String word) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedList = prefs.getStringList(SHARED_PREF_KEY);

    if (savedList == null) {
      savedList = List<String>();
    }
    savedList.add(word);

    await prefs.setStringList(SHARED_PREF_KEY, savedList);
    _suggestions[word] = true;
  }

  void removeWordPair(String word) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedList = prefs.getStringList(SHARED_PREF_KEY);

    if (savedList != null) {
      savedList.remove(word);
      await prefs.setStringList(SHARED_PREF_KEY, savedList);
      _suggestions[word] = false;
    }
  }

  void updateFavoriteInMemory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedList = prefs.getStringList(SHARED_PREF_KEY);

    if (savedList != null) {
      Map<String, bool> newSuggestions = HashMap();

      newSuggestions.addAll(_suggestions);
      savedList.forEach((savedWord) => {
            if (newSuggestions.keys.toList().contains(savedWord))
              {print("values matched"), newSuggestions[savedWord] = true}
          });

      setState(() {
        print("Setting state after updating values");
        _suggestions = newSuggestions;
      });
    }
  }
}
