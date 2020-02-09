import 'package:busicard/models/cardProfile.dart';
import 'package:busicard/qr_code/QrGen.dart';
import 'package:busicard/qr_code/Qr_Scanner.dart';
import 'package:busicard/screens/home/card_list.dart';
import 'package:busicard/services/auth.dart';
import 'package:busicard/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
  }


class _MainScreenState extends State<MainScreen> {
  final AuthService _auth = AuthService();
  int _currentIndex = 0;
  final List<Widget> _children = [
    QrScan(), //should be QrScan
    CardList(),
    QrGen(),
  ];

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<CardProfile>>.value(
      value: DatabaseService().cards,
      child: Scaffold(
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
          ],
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              title: Text("Scan"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("profile"),
            ),
          ],
        ),
      )
    );
  }
  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }
}
