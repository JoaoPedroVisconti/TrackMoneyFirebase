import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_money/models/user_model.dart';
import 'package:track_money/services/auth_service.dart';
import 'package:track_money/services/database_service.dart';
import 'package:track_money/shared/constants.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class WalletForm extends StatefulWidget {
  const WalletForm({Key? key}) : super(key: key);

  @override
  _WalletFormState createState() => _WalletFormState();
}

class _WalletFormState extends State<WalletForm> {
  final AuthService _auth = AuthService();
  // Collection reference
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();

  String? username;
  String? name;
  String? description;
  double? balance;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

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
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(40, 60, 40, 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      validator: (val) => val == null || val.isEmpty
                          ? 'Please enter a name'
                          : null,
                      onChanged: (val) {
                        setState(() {
                          name = val;
                        });
                      },
                      decoration: formInputDecoration('Wallet Name')),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      validator: (val) =>
                          val == null ? 'Something Wrong' : null,
                      onChanged: (val) {
                        setState(() {
                          description = val;
                        });
                      },
                      decoration: formInputDecoration('Description')),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (val) =>
                        val == null || val.isEmpty ? '0.0' : null,
                    onChanged: (val) {
                      if (val.length > 0) {
                        val = val.substring(0, val.length - 1);
                      }
                      setState(() {
                        balance = double.parse(val);
                      });
                    },
                    decoration: moneyInputDecoration('Initial Balance'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      MoneyInputFormatter(
                        trailingSymbol: MoneySymbols.DOLLAR_SIGN,
                        thousandSeparator: ThousandSeparator.Comma,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ButtonTheme(
                      minWidth: 200,
                      height: 100,
                      child: OutlinedButton(
                        child: Text(
                          'Create',
                        ),
                        style: outlineButtonStyle(Colors.green),
                        onPressed: () async {
                          QuerySnapshot<Map<String, dynamic>> snapshot =
                              await db
                                  .collection('users')
                                  .limit(1)
                                  .where('userId', isEqualTo: user!.uid)
                                  .get();

                          List<QueryDocumentSnapshot> docs = snapshot.docs;

                          for (var doc in docs) {
                            if (doc.data() != null) {
                              username = doc.get('username');
                            }
                          }

                          DatabaseService(uid: user.uid).createWallet(
                              username ?? '', name ?? '', description ?? '', balance ?? 0.00);

                          Navigator.pop(context);
                          // print(username);
                          // print(name);
                          // print(description);
                          // print(balance.toString());
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ButtonTheme(
                      minWidth: 200,
                      height: 100,
                      child: OutlinedButton(
                        child: Text(
                          'Cancel',
                        ),
                        style: outlineButtonStyle(Colors.red),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ));
  }
}
