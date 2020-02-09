import 'dart:math';

import 'package:busicard/models/user.dart';
import 'package:busicard/qr_code/Qr_Scanner.dart';
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
    var rng = new Random();

    final user = Provider.of<User>(context);

    return Scaffold(


      body: Center(
        child: Column(

          children: <Widget>[
            QrImage(
              data: user.uid,
              version: rng.nextInt(25),

            )
          ],
        ),

      ),



    );



  }
}
