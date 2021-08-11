import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_money/models/wallet_model.dart';
import 'package:track_money/screens/home/wallet_list.dart';
import 'package:track_money/screens/wallet/wallet_form.dart';
import 'package:track_money/services/auth_service.dart';
import 'package:track_money/services/database_service.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Wallet>?>.value(
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
        body: Container(child: WalletList()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => WalletForm()));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.purple,         
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      ),
    );
  }
}
