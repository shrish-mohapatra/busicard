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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          title: Text(
            card.name,
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
              '${card.businessName}\n'
              '${card.name}\n'
              '${card.tagline}\n'
              '${card.jobTitle}\n'
              '${card.website}\n'
              '${card.email}\n'
              '${card.phone}',
              style: TextStyle(color: Colors.white70),
          ),
        ),
      )
    );
  }
}
