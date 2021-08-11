import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:track_money/models/wallet_model.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  // Collection reference
  final CollectionReference walletsCollection =
      FirebaseFirestore.instance.collection('wallets');

  Future createWallet(String name, String description, double balance) async {
    return await walletsCollection.doc(uid).set({
      'name': name,
      'description': description,
      'balance': balance,
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
    return walletsCollection.snapshots().map(_walletListFromSnapshot);
  }
}
