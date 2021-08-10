import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Money Tracker'),
        backgroundColor: Colors.blueGrey,
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.account_balance_wallet_rounded),
            label: Text('Wallets'),
            onPressed: () async {},
            style: TextButton.styleFrom(primary: Colors.blue[50]),
          )
        ],
      ),
    );
  }
}
