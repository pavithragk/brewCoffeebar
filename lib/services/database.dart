import 'package:brew_crew/models/UserModel.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final String uid;
  DatabaseServices({this.uid});
  final CollectionReference brewCollections =
      FirebaseFirestore.instance.collection("brews");

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollections
        .doc(uid)
        .set({'sugars': sugars, 'name': name, 'strength': strength});
  }


  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Brew(
        name: doc["name"] ?? '',
        sugar: doc["sugars"] ?? '0',
        strength: doc["strength"] ?? 0,
      );
    }).toList();

  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      sugars: snapshot.data()['sugars'],
      strength: snapshot.data()['strength']
      
    );
  }

  Stream<List<Brew>> get brews{
    return brewCollections.snapshots().map((_brewListFromSnapshot));
  }

  Stream<UserData>get userData{
    return brewCollections.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
