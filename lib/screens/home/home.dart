import 'package:busicard/models/cardProfile.dart';
import 'package:busicard/screens/home/card_list.dart';
import 'package:busicard/screens/home/profile_form.dart';
import 'package:busicard/services/auth.dart';
import 'package:busicard/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showProfile() {
      showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
          builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: ProfileForm(),
        );
      }
      );
    }

    return StreamProvider<List<CardProfile>>.value(
      value: DatabaseService().cards,
      child: Scaffold(
        backgroundColor: Colors.white24,
        appBar: AppBar(
          title: Text('Busicard'),
          backgroundColor: Colors.black87,
          actions: <Widget>[
            FlatButton.icon(
              // Logout
              icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white
              ),
              label: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(
                  Icons.person,
                  color: Colors.white
              ),
              label: Text(
                'Profile',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => _showProfile(),
            )
          ],
        ),
        body: CardList(),
      )
    );
  }
}
