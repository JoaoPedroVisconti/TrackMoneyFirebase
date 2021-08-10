import 'package:cloud_firestore/cloud_firestore.dart';

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
      'balance': name,
    });
  }

  // Get Wallets stream
  Stream<QuerySnapshot> get walletsStream {
    return walletsCollection.snapshots();
  }
}
