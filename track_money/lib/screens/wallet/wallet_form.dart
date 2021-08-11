import 'package:flutter/material.dart';
import 'package:track_money/services/auth_service.dart';

class WalletForm extends StatefulWidget {
  const WalletForm({Key? key}) : super(key: key);

  @override
  _WalletFormState createState() => _WalletFormState();
}

class _WalletFormState extends State<WalletForm> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                    child: Text('Back'),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
