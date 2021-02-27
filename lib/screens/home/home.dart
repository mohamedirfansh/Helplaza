import 'package:flutter/material.dart';
import 'package:helplaza/constants.dart';
import 'package:helplaza/models/task.dart';
import 'package:helplaza/services/auth.dart';
import 'package:helplaza/services/database.dart';
import 'package:provider/provider.dart';
import 'package:helplaza/screens/home/task_list.dart';
//import 'package:helplaza/screens/authenticate/sign_in.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Task>>.value(
      value: DatabaseService().tasks,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Helplaza'),
          backgroundColor: kPrimaryColor,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: TaskList(),
      ),
    );
  }
}
