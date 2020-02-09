import 'dart:math';

import 'package:flutter/material.dart';

import 'package:busicard/Qr_Code/Qr_Scanner.dart';
import 'dart:math';

import 'package:qr_flutter/qr_flutter.dart';



class AnApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'flutter demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: "Flutter Qr"),
    );

  }
}

class MyHomePage extends StatefulWidget{

  MyHomePage({Key key, this.title}):super(key:key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage>{

  @override
  Widget build(BuildContext context) {
    var rng = new Random();

    return Scaffold(

      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(

          children: <Widget>[
            QrImage(
              data: MyApp().yourQR ,
              version: rng.nextInt(25),

            )
          ],
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder:(context)=> MyApp()));
        },
        child: Text("back"),
      ),


    );



  }
}
