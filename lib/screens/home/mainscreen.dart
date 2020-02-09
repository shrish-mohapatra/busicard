import 'package:busicard/models/cardProfile.dart';
import 'package:busicard/qr_code/QrGen.dart';
import 'package:busicard/qr_code/Qr_Scanner.dart';
import 'package:busicard/screens/home/card_list.dart';
import 'package:busicard/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
  }


class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    CardList(), //should be QrScan
    CardList(),
    QrGen(),
  ];
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<CardProfile>>.value(
      value: DatabaseService().cards,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cardshare"),
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
