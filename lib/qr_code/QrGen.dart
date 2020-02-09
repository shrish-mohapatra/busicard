import 'dart:math';

import 'package:busicard/models/user.dart';
import 'package:busicard/qr_code/Qr_Scanner.dart';
import 'package:busicard/services/database.dart';
import 'package:busicard/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:math';

import 'package:qr_flutter/qr_flutter.dart';

class QrGen extends StatefulWidget{

  //QrGen({Key key, this.title}):super(key:key);
  @override
  _QrGenState createState() => _QrGenState();
}

class _QrGenState extends State<QrGen>{

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    try {
      return StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData userData = snapshot.data;

              return Scaffold(
                body: Center(
                  child: Column(

                    children: <Widget>[
                      QrImage(
                        data: userData.email ?? 'error',
                        version: 4,

                      ),
                      SizedBox(height: 20.0),
                      Text(
                        userData.name,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        userData.jobTitle + '\n' + userData.email,
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

                ),
              );
            } else {
              return Loading();
            }
          }
      );
    } catch(e) {
      return Loading();
    }
  }
}
