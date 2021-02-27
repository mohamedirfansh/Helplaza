import 'package:flutter/material.dart';
import 'package:helplaza/screens/authenticate/signin/components/background.dart';
import 'package:helplaza/screens/authenticate/signup/register.dart';
import 'package:helplaza/components/already_have_an_account_acheck.dart';
import 'package:helplaza/components/rounded_button.dart';
import 'package:helplaza/components/rounded_input_field.dart';
import 'package:helplaza/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helplaza/services/auth.dart';

class Body extends StatefulWidget {
  //final Function toggleView;

  const Body({
    Key key,
    //this.toggleView
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthService _auth = AuthService();

  // Function to check if input fields are valid
  bool _formKey() {
    if (email.length == 0 || password.length < 6) {
      return false;
    } else {
      return true;
    }
  }

  // Text field state
  String email = '';
  String password = '';
  String invalid = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                setState(() => email = value);
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                setState(() => password = value);
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () async {
                if (!_formKey()) {
                  setState(() =>
                      invalid = 'Please enter a valid email and password!');
                  print('DEBUG!');
                } else {
                  setState(() => invalid = '');
                  print('Vlaid');
                  dynamic result =
                      await _auth.signInWithEmailAndPassword(email, password);
                  if (result == null) {
                    setState(() =>
                        invalid = 'Could not login with those credentials!');
                  }
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              invalid,
              style: TextStyle(color: Colors.red[400]),
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                //widget.toggleView();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Register();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
