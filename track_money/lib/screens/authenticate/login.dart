import 'package:flutter/material.dart';
import 'package:track_money/services/auth_service.dart';
import 'package:track_money/shared/constants.dart';
import 'package:track_money/shared/loading.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  const Login({required this.toggleView});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // TextField State
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

      dynamic result = await _auth.loginWithEmailAndPassword(email, password);

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
              title: Text('Login'),
              actions: [
                TextButton.icon(
                    style: TextButton.styleFrom(primary: Colors.white),
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.app_registration_rounded),
                    label: Text('Register'))
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
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
                        child: Text('Login'),
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
          );
  }
}
