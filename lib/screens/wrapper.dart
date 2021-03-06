import 'package:busicard/models/user.dart';
import 'package:busicard/screens/authenticate/authenticate.dart';
import 'package:busicard/screens/home/home.dart';
import 'package:busicard/screens/home/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    // return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return MainScreen();
    }
  }
}
