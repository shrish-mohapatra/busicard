import 'package:busicard/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:busicard/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text('Sign in to Busicard'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: RaisedButton(
          child: Text('Sign In Anon'),
          onPressed: () async {
            dynamic result = await _auth.signInAnon();

            if (result == null) {
              print('error signing in');
            } else {
              print('signed in');
              print(result);
            }
          },
        )
      ),
    );
  }
}
