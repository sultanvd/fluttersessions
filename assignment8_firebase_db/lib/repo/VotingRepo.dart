
import 'package:assignment8firebasedb/model/VoteItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VotingRepo{

  Future<List<VoteItem>> votingList;
  bool isUpdating = false;


  VotingRepo(){
    this.votingList = Future(() => List());
  }

  Future<List<VoteItem>> getVotingItemList(){
    return votingList;
  }

  CollectionReference getFirebaseCollection(){
    return Firestore.instance.collection('Voting');
  }

  void setListItems(List<VoteItem> voteItem){
    voteItem.sort((a, b) => (a.count < b.count)? 1 : 0);
    this.votingList = Future(() => voteItem);
  }

  void updateVote(VoteItem voteItem) {
    if(isUpdating) return;

    isUpdating = true;
    final DocumentReference voteRef = getFirebaseCollection().document(voteItem.title);
    Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot postSnapshot = await tx.get(voteRef);
      if (postSnapshot.exists) {
        await tx.update(voteRef, <String, dynamic>{'count': postSnapshot.data['count'] + 1});
        isUpdating = false;
      } else {
        isUpdating = false;
      }
    });

  }
}