import 'dart:async';
import 'package:baobabart/core/models/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskService {
  final String uid;
  TaskService({this.uid});

  // collection reference todos
  final CollectionReference todoCollection =
      Firestore.instance.collection('tasks');

  // updata todo database collection
  Future<void> updateTaskData(
      String uid, String title, String discription, bool done) async {
    return await todoCollection.document(uid).setData(
        {'uid': uid, 'title': title, 'discription': discription, 'done': done});
  }

  createTasks(String uid, String title, String description, bool done) async {
    return await todoCollection.document(uid).setData({
      'uid': uid,
      'title': title,
      'description': description,
      'done': done
    }).whenComplete(() => print('Created!!!'));
  }
}
