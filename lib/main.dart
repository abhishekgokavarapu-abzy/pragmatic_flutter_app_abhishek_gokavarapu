import 'package:flutter/material.dart';
import 'package:pragmatic_test_flutter_app/provider/appDataProvider.dart';
import 'package:pragmatic_test_flutter_app/screens/create_report_screen.dart';
import 'package:pragmatic_test_flutter_app/screens/final_report_screen.dart';
import 'package:pragmatic_test_flutter_app/screens/loading_screen.dart';
import 'package:pragmatic_test_flutter_app/screens/login_screen.dart';
import 'package:pragmatic_test_flutter_app/screens/report_screen.dart';
import 'package:pragmatic_test_flutter_app/screens/sign_up_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ListenableProvider(
      create: (context) => AppDataProvider(), child: PragmaticApp()));
}

class PragmaticApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        ReportScreen.id: (context) => ReportScreen(),
        LoadingScreen.id: (context) => LoadingScreen(),
        CreateReportScreen.id: (context) => CreateReportScreen(),
        FinalReportScreen.id: (context) => FinalReportScreen()
      },
    );
  }
}
