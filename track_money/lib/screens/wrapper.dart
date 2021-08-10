import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_money/screens/authenticate/authenticate.dart';
import 'package:track_money/screens/home/home.dart';
import 'package:track_money/models/user_model.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    print('${user?.uid} wrapper.dart-14');

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
