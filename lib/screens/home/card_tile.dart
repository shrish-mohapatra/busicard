import 'package:busicard/models/cardProfile.dart';
import 'package:flutter/material.dart';

class CardTile extends StatelessWidget {

  final CardProfile card;

  CardTile({ this.card });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:8.0),
      child: Card(
        elevation: 8.0,
        color: Colors.black87,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.white70,
          ),
          title: Text(
            card.name,
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
              '${card.businessName}\n'
              'Email: ${card.email}',
              style: TextStyle(color: Colors.white70),
          ),
        ),
      )
    );
  }
}
