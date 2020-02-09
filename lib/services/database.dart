import 'package:busicard/models/cardProfile.dart';
import 'package:busicard/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference cardCollection = Firestore.instance.collection('cards');

  Future updateUserData(String businessName, String name, String tagline,
      String jobTitle, String website, String email, String phone, String networkHash) async {
    return await cardCollection.document(uid).setData({
      'businessName': businessName,
      'name': name,
      'tagline': tagline,
      'jobTitle': jobTitle,
      'website': website,
      'email': email,
      'phone': phone,
      'networkHash': networkHash
    });
  }

  // card list from snapshot
  List<CardProfile> _cardListFromSnapshot(QuerySnapshot snapshot) {
    List<CardProfile> allCards = snapshot.documents.map((doc){
      return CardProfile(
        businessName: doc.data['businessName'] ?? '',
        name: doc.data['name'] ?? '',
        tagline: doc.data['tagline'] ?? '',
        jobTitle: doc.data['jobTitle'] ?? '',
        website: doc.data['website'] ?? '',
        email: doc.data['email'] ?? '',
        phone: doc.data['phone'] ?? '',
      );
    }).toList();

    return allCards;
  }

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      businessName: snapshot.data['businessName'],
      name: snapshot.data['name'],
      tagline: snapshot.data['tagline'],
      jobTitle: snapshot.data['jobTitle'],
      website: snapshot.data['website'],
      email: snapshot.data['email'],
      phone: snapshot.data['phone'],
      networkHash: snapshot.data['networkHash']
    );
  }

  // get card stream
  Stream<List<CardProfile>> get cards {
    return cardCollection.snapshots().map(_cardListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return cardCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }
}