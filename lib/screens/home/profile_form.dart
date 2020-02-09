import 'package:busicard/models/user.dart';
import 'package:busicard/services/database.dart';
import 'package:busicard/shared/constants.dart';
import 'package:busicard/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {

  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentBusinessName;
  String _currentName;
  String _currentTagline;
  String _currentJobTitle;
  String _currentWebsite;
  String _currentEmail;
  String _currentPhone;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {

        if(snapshot.hasData) {

          UserData userData = snapshot.data;

          return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
              key: _formKey,
              child: ListView(
                  children: <Widget>[
                    Text(
                      'Update your profile.',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0),

                    TextFormField(
                      initialValue: userData.name,
                      decoration: textInputDecoration,
                      validator: (val) =>
                      val.isEmpty
                          ? 'Please enter a name'
                          : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(height: 20.0),

                    TextFormField(
                      initialValue: userData.businessName,
                      decoration: textInputDecoration,
                      validator: (val) =>
                      val.isEmpty
                          ? 'Please enter a business name'
                          : null,
                      onChanged: (val) =>
                          setState(() => _currentBusinessName = val),
                    ),
                    SizedBox(height: 20.0),

                    TextFormField(
                      initialValue: userData.jobTitle,
                      decoration: textInputDecoration,
                      validator: (val) =>
                      val.isEmpty
                          ? 'Please enter a job title'
                          : null,
                      onChanged: (val) => setState(() => _currentJobTitle = val),
                    ),
                    SizedBox(height: 20.0),

                    TextFormField(
                      initialValue: userData.tagline,
                      decoration: textInputDecoration,
                      validator: (val) =>
                      val.isEmpty
                          ? 'Please enter a tagline'
                          : null,
                      onChanged: (val) =>
                          setState(() => _currentTagline = val),
                    ),
                    SizedBox(height: 20.0),

                    TextFormField(
                      initialValue: userData.website,
                      decoration: textInputDecoration,
                      validator: (val) =>
                      val.isEmpty
                          ? 'Please enter a website'
                          : null,
                      onChanged: (val) => setState(() => _currentWebsite = val),
                    ),
                    SizedBox(height: 20.0),

                    TextFormField(
                      initialValue: userData.phone,
                      decoration: textInputDecoration,
                      validator: (val) =>
                      val.isEmpty
                          ? 'Please enter a phone #'
                          : null,
                      onChanged: (val) => setState(() => _currentPhone = val),
                    ),
                    SizedBox(height: 20.0),

                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                            _currentBusinessName ?? userData.businessName,
                            _currentName ?? userData.name,
                            _currentTagline ?? userData.tagline,
                            _currentJobTitle ?? userData.jobTitle,
                            _currentWebsite ?? userData.website,
                            userData.email,
                            _currentPhone ?? userData.phone,
                            userData.networkHash
                          );
                        }
                      },
                    ),
                    SizedBox(height: 250.0),
                  ]
              ),
            )
          );
        } else {
          return Loading();
        }
      });
  }
}
