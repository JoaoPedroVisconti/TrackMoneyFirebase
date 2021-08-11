import 'package:flutter/material.dart';
import 'package:track_money/services/auth_service.dart';

class WalletForm extends StatefulWidget {
  const WalletForm({Key? key}) : super(key: key);

  @override
  _WalletFormState createState() => _WalletFormState();
}

class _WalletFormState extends State<WalletForm> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  String? username;
  String? name;
  String? description;
  double? balance;

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
          padding: EdgeInsets.fromLTRB(40, 60, 40, 0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Wallet Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.purple, width: 2)
                    )
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
