import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  const Login({required this.toggleView});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Login page')
    );
  }
}
