import 'package:flutter/material.dart';
import 'package:helplaza/models/task.dart';
import 'package:helplaza/screens/home/task_tile.dart';
import 'package:provider/provider.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context);
    tasks.forEach((task) {
      print(task.name);
      print(task.price);
      print(task.urgency);
      print(task.task);
    });

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskTile(task: tasks[index]);
      },
    );
  }
}
