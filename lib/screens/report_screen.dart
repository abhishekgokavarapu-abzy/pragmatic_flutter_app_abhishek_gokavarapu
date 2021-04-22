import 'package:flutter/material.dart';
import 'package:pragmatic_test_flutter_app/widgets/report_screen_body.dart';

class ReportScreen extends StatelessWidget {
  static const String id = 'report_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReportScreenBody(),
    );
  }
}
