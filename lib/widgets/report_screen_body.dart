import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pragmatic_test_flutter_app/provider/appDataProvider.dart';
import 'package:pragmatic_test_flutter_app/screens/final_report_screen.dart';
import 'package:pragmatic_test_flutter_app/screens/loading_screen.dart';
import 'package:pragmatic_test_flutter_app/screens/login_screen.dart';
import 'package:pragmatic_test_flutter_app/utils/services/rest_api_service.dart';
import 'package:provider/provider.dart';

class ReportScreenBody extends StatefulWidget {
  @override
  _ReportScreenBodyState createState() => _ReportScreenBodyState();
}

class _ReportScreenBodyState extends State<ReportScreenBody> {
  _fetchReports() async {
    var responseData =
        await ApiService.getReports(context.read<AppDataProvider>().authKey);
    if (responseData.statusCode != 200) {
      print(responseData.statusCode);
      Navigator.pushNamed(context, LoginScreen.id);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Unable to Fetch reports - Log-In again'),
              ));
    } else {
      List<Map<dynamic, dynamic>> reports =
          List.from(jsonDecode(responseData.body));
      Provider.of<AppDataProvider>(context, listen: false).saveReports(reports)
          as List;
      Navigator.pushNamed(context, FinalReportScreen.id);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchReports();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen();
  }
}

// SafeArea(
// child: SingleChildScrollView(
// child: Column(
// children: [Text('UserName'), Text('reports')],
// )));
