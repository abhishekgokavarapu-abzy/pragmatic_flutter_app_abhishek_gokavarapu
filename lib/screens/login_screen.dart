import 'package:flutter/material.dart';
import 'package:pragmatic_test_flutter_app/widgets/login_screen_body.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreenBody(),
    );
  }
}
