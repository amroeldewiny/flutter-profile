import 'package:baobabart/core/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:baobabart/core/models/profile.dart';

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

  // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //

  // collection reference todos
  final CollectionReference todoCollection =
      Firestore.instance.collection('todos');

  // updata todo database collection
  Future<void> updateTodoData(
      String uid, String title, String discription, bool done) async {
    return await todoCollection.document(uid).setData(
        {'uid': uid, 'title': title, 'discription': discription, 'done': done});
  }

  // todos List from snapshop database
  List<UserTodo> _todoListFromDB(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return UserTodo(
        uid: doc.data['uid'] ?? '',
        title: doc.data['title'] ?? '',
        discription: doc.data['discription'] ?? '',
        done: doc.data['done'] ?? '',
      );
    }).toList();
  }

  //  todo data from snapshots
  UserTodo _todoDataFromDB(DocumentSnapshot snapshot) {
    return UserTodo(
      uid: uid,
      title: snapshot.data['name'],
      discription: snapshot.data['discription'],
      done: snapshot.data['done'],
    );
  }

  // get todos stream
  Stream<List<UserTodo>> get todos {
    return userCollection.snapshots().map(_todoListFromDB);
  }

  // get todo doc stream
  Stream<UserTodo> get userTodo {
    return todoCollection.document(uid).snapshots().map(_todoDataFromDB);
  }
}
