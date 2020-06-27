import 'package:assignment8firebasedb/model/VoteItem.dart';
import 'package:assignment8firebasedb/repo/VotingRepo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseDbWidget extends StatelessWidget {
  final VotingRepo repo;

  FirebaseDbWidget(this.repo);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: repo.getFirebaseCollection().snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        handleDocumentData(snapshot.data.documents);
        return Container();
      },
    );
  }

  void handleDocumentData(List<DocumentSnapshot> data){
    var list = data.map((data) => VoteItem(data.data["id"], data.data["name"], data.data["count"])).toList();
    repo.setListItems(list);
  }
}
