import 'package:cloud_firestore/cloud_firestore.dart';

addToScouterScore(int howMuchToAd, String userId) async{
  int score = await getUserScore(userId);
  Firestore.instance.collection('users').document(userId).updateData({
    'score': score + howMuchToAd
  });
}

Future<int> getUserScore(String userId) {
  return Firestore.instance.collection('users').document(userId).get()
      .then((res) {
        return res.data['score'];
  });
}