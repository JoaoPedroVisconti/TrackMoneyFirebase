import 'package:flutter/material.dart';
import 'package:track_money/services/auth_service.dart';

class Home extends StatelessWidget {

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
    );
  }
}
