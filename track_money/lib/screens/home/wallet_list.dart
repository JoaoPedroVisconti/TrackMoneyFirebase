import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class WalletList extends StatefulWidget {
  const WalletList({Key? key}) : super(key: key);

  @override
  _WalletListState createState() => _WalletListState();
}

class _WalletListState extends State<WalletList> {
  @override
  Widget build(BuildContext context) {
    final wallets = Provider.of<QuerySnapshot?>(context);

    if (wallets != null) {
      for (var doc in wallets.docs) {
        print(doc.data());
      }
    }

    return Container();
  }
}
