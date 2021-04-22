import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  static const String id = 'loading_screen';
  @override
  Widget build(BuildContext context) {
    return SpinKitDualRing(
      color: Colors.blue,
    );
  }
}
