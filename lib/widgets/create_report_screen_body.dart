import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pragmatic_test_flutter_app/screens/loading_screen.dart';
import 'package:pragmatic_test_flutter_app/screens/report_screen.dart';
import 'package:pragmatic_test_flutter_app/utils/services/rest_api_service.dart';

class CreateReportScreenBody extends StatefulWidget {
  @override
  _CreateReportScreenBodyState createState() => _CreateReportScreenBodyState();
}

class _CreateReportScreenBodyState extends State<CreateReportScreenBody> {
  String title;
  String description;
  File file;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    _choose() async {
      final pickedFile = await picker.getImage(
          source: ImageSource.gallery, maxHeight: 400, maxWidth: 400);
      file = File(pickedFile.path);
    }

    _upload() async {
      if (file != null) {
        Navigator.pushNamed(context, LoadingScreen.id);
        int statusCode = await ApiService.uploadImage(file);
        Navigator.pop(context);
        if (statusCode != 201) {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Error - Upload Again!'),
                  ));
        } else {
          print(statusCode);
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Uploaded Successfully!!'),
                  ));
        }
      } else
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Choose File'),
                ));
    }

    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('CREATE REPORT'),
          TextButton(
              onPressed: () {
                _choose();
              },
              child: Text('CHOOSE')),
          TextButton(
              onPressed: () {
                _upload();
              },
              child: Text('UPLOAD')),
          TextField(
            onChanged: (value) {
              title = value;
            },
            decoration: InputDecoration(hintText: 'Enter Title'),
          ),
          TextField(
            onChanged: (value) {
              description = value;
            },
            decoration: InputDecoration(hintText: 'Enter Description'),
          ),
          TextButton(
              onPressed: () async {
                var responseData =
                    await ApiService.createReport(title, description);
                Navigator.pushNamed(context, LoadingScreen.id);
                if (responseData.statusCode != 200) {
                  var a = jsonDecode(responseData.body);
                  print(a);
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('Error - Submit Report Again.'),
                          ));
                } else {
                  Navigator.pushNamed(context, ReportScreen.id);
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('Report Submitted Successfully!!'),
                          ));
                }
              },
              child: Text('CREATE REPORT'))
        ],
      ),
    ));
  }
}
