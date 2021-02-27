import 'package:flutter/material.dart';
import 'package:helplaza/models/user.dart';
import 'package:helplaza/screens/authenticate/authenticate.dart';
import 'package:helplaza/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Return either home or authenticate widget

    final user = Provider.of<User>(context);

    // Return either Home or Authenticate widget based on if the user is logged in
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
