import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:track_money/models/wallet_card.dart';
import 'package:track_money/models/wallet_model.dart';

class WalletList extends StatefulWidget {
  const WalletList({Key? key}) : super(key: key);

  @override
  _WalletListState createState() => _WalletListState();
}

class _WalletListState extends State<WalletList> {
  @override
  Widget build(BuildContext context) {
    final wallets = Provider.of<List<Wallet>?>(context);

    if (wallets != null) {
      return Swiper(
        itemCount: wallets.length,
        itemBuilder: (context, index) {
          return WalletCard(
            wallet: wallets[index],
          );
        },
      );
    } else {
      return Container(
        child: Text('No wallets'),
      );
    }
  }
}
