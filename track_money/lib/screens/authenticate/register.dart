import 'package:flutter/material.dart';
import 'package:track_money/services/auth_service.dart';

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
  String email = '';
  String password = '';
  String error = '';

  // Handle register
  void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      dynamic result =
          await _auth.registerWithEmailAndPassword(email, password);

      if (result == null) {
        setState(() {
          error = 'Something went wrong, please try again';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'Enter an email' : null,
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
                  style: ElevatedButton.styleFrom(primary: Colors.purple[800]),
                  child: Text('Register'),
                  onPressed: () async {
                    handleSubmit();
                  }
              ),
              SizedBox(height: 12,),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
