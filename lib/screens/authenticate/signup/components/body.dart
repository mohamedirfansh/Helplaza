import 'package:flutter/material.dart';
import 'package:helplaza/screens/authenticate/signin/sign_in.dart';
import 'package:helplaza/screens/authenticate/signup/components/background.dart';
import 'package:helplaza/screens/authenticate/signup/components/or_divider.dart';
import 'package:helplaza/screens/authenticate/signup/components/social_icon.dart';
import 'package:helplaza/components/already_have_an_account_acheck.dart';
import 'package:helplaza/components/rounded_button.dart';
import 'package:helplaza/components/rounded_input_field.dart';
import 'package:helplaza/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helplaza/services/auth.dart';
import 'package:helplaza/shared/loading.dart';

class Body extends StatefulWidget {
  // final Function toggleView;
  // Body({this.toggleView});

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

  bool loading = false;

  // Text field state
  String email = '';
  String password = '';
  String invalid = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Background(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "SIGNUP",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    "assets/icons/signup.svg",
                    height: size.height * 0.35,
                  ),
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
                    text: "SIGNUP",
                    press: () async {
                      if (!_formKey()) {
                        setState(() => invalid =
                            'Please enter a valid email and password!');
                        print('DEBUG!');
                      } else {
                        setState(() {
                          invalid = '';
                          loading = true;
                        });
                        dynamic result = await _auth
                            .registerWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() {
                            invalid =
                                'Please enter a valid email and password!';
                            loading = false;
                          });
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
                    login: false,
                    press: () {
                      //widget.toggleView();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignIn();
                          },
                        ),
                      );
                    },
                  ),
                  // OrDivider(),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     SocalIcon(
                  //       iconSrc: "assets/icons/facebook.svg",
                  //       press: () {},
                  //     ),
                  //     SocalIcon(
                  //       iconSrc: "assets/icons/twitter.svg",
                  //       press: () {},
                  //     ),
                  //     SocalIcon(
                  //       iconSrc: "assets/icons/google-plus.svg",
                  //       press: () {},
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          );
  }
}
