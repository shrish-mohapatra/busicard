import 'package:busicard/models/cardProfile.dart';
import 'package:busicard/models/user.dart';
import 'package:busicard/screens/home/card_tile.dart';
import 'package:busicard/services/database.dart';
import 'package:busicard/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardList extends StatefulWidget {
  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {

    final cards = Provider.of<List<CardProfile>>(context) ?? [];
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {

          if(snapshot.hasData) {
            UserData userData = snapshot.data;
            List<CardProfile> newCards = new List<CardProfile>();

            for (int i = 0; i < cards.length; i++) {
              if (userData.email == cards[i].email) {
                newCards.add(cards[i]);
              }
            }

            for (int i = 0; i < cards.length; i++) {
              if (userData.networkHash.contains(cards[i].email)) {
                newCards.add(cards[i]);
              }
            }

            return ListView.builder(
              itemCount: newCards.length,
              itemBuilder: (context, index) {
                return CardTile(card: newCards[index]);
              },
            );
          } else {
            return Loading();
          }
        }
    );
  }
}
