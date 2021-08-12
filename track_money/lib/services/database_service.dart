import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:track_money/models/user_model.dart';
import 'package:track_money/models/wallet_model.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  // Collection reference
  final FirebaseFirestore db = FirebaseFirestore.instance;
  
  // Create a Wallet
  Future createWallet(
      String username, String name, String description, double balance) async {
    if (name == '') {
      print('Username must not be empty');
    } else {
      return await db.collection('wallets').doc().set({
        'username': username,
        'name': name,
        'description': description,
        'balance': balance,
      });
    }
  }

  // Wallet list from snapshot
  List<Wallet> _walletListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Wallet(
          username: doc.get('username') ?? '',
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
