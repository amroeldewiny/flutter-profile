import 'dart:async';
import 'package:baobabart/core/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:baobabart/core/models/profile.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference users
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  // updata user database collection
  Future<void> updateUserData(
      String uid, String name, String email, String job, String image) async {
    return await userCollection.document(uid).setData(
        {'uid': uid, 'name': name, 'email': email, 'job': job, 'image': image});
  }

  // users List from snapshop database
  List<Profile> _userListFromDB(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return Profile(
        uid: doc.data['uid'] ?? '',
        name: doc.data['name'] ?? '',
        email: doc.data['email'] ?? '',
        job: doc.data['job'] ?? '',
        image: doc.data['image'] ?? '',
      );
    }).toList();
  }

  Future uploadFile(img) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(img);
  }

  // user data from snapshots
  UserProfile _userDataFromDB(DocumentSnapshot snapshot) {
    return UserProfile(
      uid: uid,
      name: snapshot.data['name'],
      email: snapshot.data['email'],
      job: snapshot.data['job'],
      image: snapshot.data['image'],
    );
  }

  // get brews stream
  Stream<List<Profile>> get profiles {
    return userCollection.snapshots().map(_userListFromDB);
  }

  // get user doc stream
  Stream<UserProfile> get userProfile {
    return userCollection.document(uid).snapshots().map(_userDataFromDB);
  }

  // get user doc stream by name for search
  getUserByName(String username) {
    return userCollection.where("name", isEqualTo: username);
  }
}
