import 'package:flutter/material.dart';
import 'package:track_money/models/wallet_model.dart';

class WalletCard extends StatelessWidget {
  final Wallet wallet;

  const WalletCard({required this.wallet});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(60, 50, 60, 200),
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text(wallet.name),
              subtitle: Text(
                wallet.description,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 60),
              child: Text(
                wallet.balance.toString(),
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 48,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
