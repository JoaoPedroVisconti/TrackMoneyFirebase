import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:track_money/models/wallet_model.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  // Collection reference
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // Create a Wallet
  Future createWallet(String name, String description, double balance) async {
    return await db.collection('wallets').doc(uid).set({
      'name': name,
      'description': description,
      'balance': balance,
    });
  }

  // Create a User in Firestore
  Future createUser(String userId, String username, String email) async {
    db.doc('/users/$username').get().then((doc) => {
          if (doc.exists) {null}
          else {
            db.doc('/users/$username').set({
              'userId': userId,
              'username': username,
              'email': email,
            })
          }
        });
  }

  // Wallet list from snapshot
  List<Wallet> _walletListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Wallet(
          name: doc.get('name') ?? '',
          description: doc.get('description') ?? '',
          balance: doc.get('balance') ?? 0);
    }).toList();
  }

  // Get Wallets stream
  Stream<List<Wallet>> get walletsStream {
    return db.collection('wallets').snapshots().map(_walletListFromSnapshot);
  }
}
