import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helplaza/models/task.dart';

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

  Stream<List<Task>> get tasks {
    return taskCollection.snapshots().map(_taskListFromSnapshot);
  }
}
