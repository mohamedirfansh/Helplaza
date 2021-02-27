import 'package:flutter/material.dart';
import 'package:helplaza/constants.dart';
import 'package:helplaza/models/user.dart';
import 'package:helplaza/services/database.dart';
import 'package:helplaza/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> price = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];

  // Form values
  String _currentName;
  String _currentTask;
  String _currentPrice;
  int _currentUrgency;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Need help with something?',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Your Name'),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter your name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.task,
                    decoration: textInputDecoration.copyWith(
                        hintText: 'What do you need help with?'),
                    validator: (val) => val.isEmpty
                        ? 'Please enter something that you need help with'
                        : null,
                    onChanged: (val) => setState(() => _currentTask = val),
                  ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentPrice ?? userData.price,
                    items: price.map((p) {
                      return DropdownMenuItem(
                        value: p,
                        child: Text('\$$p'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentPrice = val),
                  ),
                  SizedBox(height: 20.0),
                  Text('How urgent is it?'),
                  SizedBox(height: 20.0),
                  Slider(
                    value: (_currentUrgency ?? userData.urgency).toDouble(),
                    activeColor:
                        Colors.red[_currentUrgency ?? userData.urgency],
                    inactiveColor:
                        Colors.red[_currentUrgency ?? userData.urgency],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentUrgency = val.round()),
                  ),
                  RaisedButton(
                      color: kPrimaryColor,
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        print(_currentName);
                        print(_currentPrice);
                        print(_currentTask);
                        print(_currentUrgency);
                      }),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
