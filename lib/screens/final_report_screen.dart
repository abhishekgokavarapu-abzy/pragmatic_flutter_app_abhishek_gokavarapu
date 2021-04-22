import 'package:flutter/material.dart';
import 'package:pragmatic_test_flutter_app/provider/appDataProvider.dart';
import 'package:pragmatic_test_flutter_app/screens/create_report_screen.dart';
import 'package:pragmatic_test_flutter_app/screens/loading_screen.dart';
import 'package:pragmatic_test_flutter_app/screens/login_screen.dart';
import 'package:pragmatic_test_flutter_app/screens/report_screen.dart';
import 'package:pragmatic_test_flutter_app/utils/services/rest_api_service.dart';
import 'package:provider/provider.dart';

class FinalReportScreen extends StatelessWidget {
  static const String id = 'final_report_screen';
  @override
  Widget build(BuildContext context) {
    String newStatusUpdate;
    List<Widget> getAllReports(List<Map<dynamic, dynamic>> reports) {
      List<Widget> reportsListWidgets = [];
      for (var report in reports) {
        String title = report['title'];
        String description = report['description'];
        String reportStatus = report['status'];
        ListTile reportWidget = ListTile(
          leading: Icon(
            Icons.arrow_forward,
            color: Colors.blue,
          ),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.w400)),
          trailing: IconButton(
              icon: Icon(
                Icons.arrow_right,
                color: Colors.red,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text(
                            title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content: Column(
                            children: [
                              Text(description,
                                  overflow: TextOverflow.fade,
                                  softWrap: true,
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                              Provider.of<AppDataProvider>(context).isAdmin
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          child: DropdownButton(
                                            hint: Text('Choose'),
                                            items: <String>[
                                              'pending'.toUpperCase(),
                                              'approved'.toUpperCase()
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              newStatusUpdate = value;
                                            },
                                          ),
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            onPressed: () async {
                                              Navigator.pushNamed(
                                                  context, LoadingScreen.id);
                                              var responseData = await ApiService
                                                  .updateReportStatus(
                                                      Provider.of<AppDataProvider>(
                                                              context,
                                                              listen: false)
                                                          .authKey,
                                                      report['pk'].toString(),
                                                      newStatusUpdate);
                                              if (responseData.statusCode !=
                                                  200) {
                                                print(responseData.body);
                                                Navigator.pushNamed(
                                                    context, LoginScreen.id);
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                          title: Text(
                                                              'Token Expired Login Again'),
                                                        ));
                                              } else {
                                                Navigator.pushNamed(
                                                    context, ReportScreen.id);
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                          title: Text(
                                                              'Report Status Updated Successfully'),
                                                        ));
                                              }
                                            }),
                                      ],
                                    )
                                  : SizedBox(
                                      height: 10.0,
                                    ),
                              Text('Report Status : $reportStatus'),
                            ],
                          ),
                        ));
              }),
        );
        reportsListWidgets.add(reportWidget);
      }
      return reportsListWidgets;
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, CreateReportScreen.id);
          },
        ),
        body: Consumer<AppDataProvider>(
            builder: (context, appData, widget) => Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ListView(
                    children: getAllReports(
                        Provider.of<AppDataProvider>(context).getReports),
                  ),
                )));
  }
}
