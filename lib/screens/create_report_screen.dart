import 'package:flutter/material.dart';
import 'package:pragmatic_test_flutter_app/widgets/create_report_screen_body.dart';

class CreateReportScreen extends StatelessWidget {
  static const String id = 'create_report_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CreateReportScreenBody(),
    );
  }
}
