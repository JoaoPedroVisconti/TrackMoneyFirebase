import 'package:flutter/material.dart';
import 'package:track_money/services/auth_service.dart';
import 'package:track_money/shared/constants.dart';
import 'package:track_money/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  const Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // TextField State
  String username = '';
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  // Handle register
  void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      dynamic result =
          await _auth.registerWithEmailAndPassword(email, password, username);

      if (result == null) {
        setState(() {
          loading = false;
          error = 'Something went wrong, please try again';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(0xFF333333),
            appBar: AppBar(
              backgroundColor: Colors.purple[800],
              title: Text('Register'),
              actions: [
                TextButton.icon(
                    style: TextButton.styleFrom(primary: Colors.white),
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.login_rounded),
                    label: Text('Login'))
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) => (val == null || val.isEmpty)
                            ? 'Enter an email'
                            : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Username'),
                        validator: (val) => (val == null || val.isEmpty)
                            ? 'Enter Username'
                            : null,
                        onChanged: (val) {
                          setState(() {
                            username = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        obscureText: true,
                        validator: (val) => (val == null || val.length < 8)
                            ? 'Enter a valid password'
                            : null,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.purple[800]),
                          child: Text('Register'),
                          onPressed: () async {
                            handleSubmit();
                          }),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
