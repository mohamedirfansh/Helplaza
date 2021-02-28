import 'package:flutter/material.dart';
import 'package:helplaza/models/user.dart';
import 'package:helplaza/screens/wrapper.dart';
import 'package:helplaza/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        //WelcomeScreen(),
      ),
    );
  }
}
