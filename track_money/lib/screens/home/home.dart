import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_money/screens/home/wallet_list.dart';
import 'package:track_money/services/auth_service.dart';
import 'package:track_money/services/database_service.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot?>.value(
      initialData: null,
      value: DatabaseService(uid: '').walletsStream,
      child: Scaffold(
        backgroundColor: Color(0xFF333333),
        appBar: AppBar(
          title: Text('Money Tracker'),
          backgroundColor: Colors.purple[800],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.logout_rounded),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.userLogout();
              },
              style: TextButton.styleFrom(primary: Colors.white),
            )
          ],
        ),
        body: WalletList(),
      ),
    );
  }
}
