import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helplaza/models/task.dart';
import 'package:helplaza/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // Collection reference
  final CollectionReference taskCollection =
      Firestore.instance.collection('tasks');

  /*
  price -> sugars
  name -> name
  urgency -> strength
  task -> NONE
  */
  Future updateUserData(
      String price, String name, int urgency, String task) async {
    return await taskCollection.document(uid).setData(
        {'price': price, 'name': name, 'urgency': urgency, 'task': task});
  }

  // Task list from snapshot
  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Task(
          name: doc.data['name'] ?? '',
          urgency: doc.data['urgency'] ?? 0,
          price: doc.data['price'] ?? '0',
          task: doc.data['task'] ?? '');
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      task: snapshot.data['task'],
      price: snapshot.data['price'],
      urgency: snapshot.data['urgency'],
    );
  }

  // Get task doc stream
  Stream<List<Task>> get tasks {
    return taskCollection.snapshots().map(_taskListFromSnapshot);
  }

  // Get user doc stream
  Stream<UserData> get userData {
    return taskCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
