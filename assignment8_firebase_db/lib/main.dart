import 'package:assignment8firebasedb/repo/VotingRepo.dart';
import 'package:assignment8firebasedb/widgets/FirebaseDbWidget.dart';
import 'package:assignment8firebasedb/widgets/VotingListWidget.dart';
import 'package:flutter/material.dart';

VotingRepo repo;

void main() {
  repo = VotingRepo();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voting App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: VotingListWidget(),
    );
  }
}