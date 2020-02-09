import 'package:busicard/models/cardProfile.dart';
import 'package:busicard/screens/home/card_tile.dart';
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

    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return CardTile(card: cards[index]);
      },
    );
  }
}
