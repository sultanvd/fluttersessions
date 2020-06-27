import 'package:assignment8firebasedb/model/VoteItem.dart';
import 'package:assignment8firebasedb/repo/VotingRepo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../main.dart';
import 'FirebaseDbWidget.dart';

class VotingListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VotingListWidgetState();
}

class VotingListWidgetState extends State<VotingListWidget> {
  VotingRepo votingRepo;
  List<VoteItem> votingList;

  VotingListWidgetState() {
    this.votingList = List();
    this.votingRepo = repo;
  }

  @override
  Widget build(BuildContext context) {
    subscribeToVotingList();
    return Scaffold(
        appBar: AppBar(
          title: Text("Animal Voting"),
          centerTitle: true,
        ),
        body: getVotingOptionListWidget());
  }

  Widget getVotingOptionListWidget() {
    return Container(
        color: Colors.blue[200],
        child: Column(children: <Widget>[
          FirebaseDbWidget(repo),
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(8),
                  shrinkWrap: true,
                  itemCount: this.votingList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return getVotingItemContainer(this.votingList[index]);
                  }))
        ]));
  }

  Widget getVotingItemContainer(VoteItem votingItem) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      elevation: 3,
      color: Colors.white70,
      child: InkWell(
          onTap: () => this.updateVoteCount(votingItem),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(votingItem.title,
                      style: TextStyle(fontSize: 30)),
                  Text(votingItem.count.toString(),
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ]),
          )),
    );
  }

  void subscribeToVotingList() {
    votingRepo.getVotingItemList().then((value) => {
          this.setState(() {
            this.votingList = value;
          })
        });
  }

  void updateVoteCount(VoteItem voteItem) {
    repo.updateVote(voteItem);
  }
}
