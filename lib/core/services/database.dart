import 'package:baobabart/core/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:baobabart/core/models/profile.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  // updata user database collection
  Future<void> updateUserData(String uid, String name, String email, String job,
      num tel, String image) async {
    return await userCollection.document(uid).setData({
      'uid': uid,
      'name': name,
      'email': email,
      'job': job,
      'tel': tel,
      'image': image
    });
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
        tel: doc.data['tel'] ?? '',
        image: doc.data['image'] ?? '',
      );
    }).toList();
  }

  // user data from snapshots
  UserProfile _userDataFromDB(DocumentSnapshot snapshot) {
    return UserProfile(
      uid: uid,
      name: snapshot.data['name'],
      email: snapshot.data['email'],
      job: snapshot.data['job'],
      tel: snapshot.data['tel'],
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
}
