import 'package:flutter/material.dart';
import 'package:helplaza/screens/authenticate/signin/sign_in.dart';
//import 'package:helplaza/screens/authenticate/signup/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return SignIn();
  }
  // bool showSignIn = true;
  // void toggleView() {
  //   setState(() => showSignIn = !showSignIn);
  // }

  // @override
  // Widget build(BuildContext context) {
  //   if (showSignIn) {
  //     return SignIn(toggleView: toggleView);
  //   } else {
  //     return Register(toggleView: toggleView);
  //   }
  // }
}
