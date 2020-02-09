import 'package:busicard/services/auth.dart';
import 'package:busicard/shared/constants.dart';
import 'package:busicard/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field states
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('CardShare'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(
              'Sign In',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                // Email field
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                // Password field
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) => val.length < 7 ? 'Enter a password 7+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmail(email, password);

                    if (result == null) {
                      setState(() {
                        error = 'Please provide proper email.';
                        loading = false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
