import 'package:flutter/material.dart';

import '../widgets/sign_up_screen_body.dart';

class SignUpScreen extends StatelessWidget {
  static const String id = 'sign_up_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUpScreenBody(),
    );
  }
}
