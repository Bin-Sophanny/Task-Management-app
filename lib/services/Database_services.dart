import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_management/model/task_model.dart';

class DatabaseServices {
  final CollectionReference taskCollection =
      FirebaseFirestore.instance.collection('tasks');
  User? user = FirebaseAuth.instance.currentUser;

  // add task to firestore
  Future<DocumentReference> createTask(String title, String description) async {
    return await taskCollection.add({
      'uid': user!.uid,
      'title': title,
      'description': description,
      'completed': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // update task
  Future<void> updateTask(String id, String title, String description) async {
    final updateTaskcollection =
        FirebaseFirestore.instance.collection('tasks').doc(id);
    return await updateTaskcollection.update({
      'title': title,
      'description': description,
    });
  }

  // update task status
  Future<void> updateTaskStatus(String id, bool completed) async {
    return await taskCollection.doc(id).update({
      'completed': completed,
    });
  }

  // delete task
  Future<void> deleteTaskStatus(String id, bool completed) async {
    return await taskCollection.doc(id).delete();
  }
  // pending task
  Stream<List<Task>> get Tasks {
    return taskCollection
        .where('uid', isEqualTo: user!.uid)
        .where('completed', isEqualTo: false)
        .snapshots()
        .map(_taskListFromSnapshot);
  }
  // completed task
  Stream<List<Task>> get completedTasks {
    return taskCollection
        .where('uid', isEqualTo: user!.uid)
        .where('completed', isEqualTo: true)
        .snapshots()
        .map(_taskListFromSnapshot);
  }
  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Task(
        id: doc.id,
        title: doc['title'] ?? '',
        description: doc['description'] ?? '',
        completed: doc['completed'] ?? false,
        timestamp: doc['createdAt'] ?? '',
      );
    }).toList();
  }
}
