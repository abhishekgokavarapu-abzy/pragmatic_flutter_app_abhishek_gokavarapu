import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pragmatic_test_flutter_app/provider/appDataProvider.dart';
import 'package:pragmatic_test_flutter_app/screens/loading_screen.dart';
import 'package:pragmatic_test_flutter_app/screens/login_screen.dart';
import 'package:pragmatic_test_flutter_app/screens/report_screen.dart';
import 'package:pragmatic_test_flutter_app/screens/sign_up_screen.dart';
import 'package:pragmatic_test_flutter_app/utils/services/rest_api_service.dart';
import 'package:provider/provider.dart';

import 'file:///C:/AndroidStudioProjects/pragmatic_test_flutter_app/lib/utils/constants/app_constants.dart';

class LoginScreenBody extends StatefulWidget {
  @override
  _LoginScreenBodyState createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  String username;
  String password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: kLoginLogo),
            TextField(
              decoration: InputDecoration(hintText: 'Username'),
              onChanged: (value) {
                username = value.trim();
              },
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password'),
              onChanged: (value) {
                password = value.trim();
              },
            ),
            TextButton(
                onPressed: () async {
                  if (username != null || password != null) {
                    Navigator.pushNamed(context, LoadingScreen.id);
                    var responseData =
                        await ApiService.obtainAccessRefreshToken(
                            username, password);
                    if (responseData.statusCode != 200) {
                      Navigator.pushNamed(context, LoginScreen.id);
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                              title: Text('Check Your Credentials')));
                    } else {
                      Map decodedResponse = jsonDecode(responseData.body);
                      Provider.of<AppDataProvider>(context, listen: false)
                          .saveAuthKey(decodedResponse['access']);
                      Provider.of<AppDataProvider>(context, listen: false)
                          .saveRefreshKey(decodedResponse['refresh']);
                      Provider.of<AppDataProvider>(context, listen: false)
                          .saveUsername(username);
                      if (username.toLowerCase() == 'admin') {
                        Provider.of<AppDataProvider>(context, listen: false)
                            .checkIfAdmin(true);
                      }
                      Navigator.pushNamed(context, ReportScreen.id);
                    }
                  } else
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                            title: Text('Fields must not be left blank')));
                },
                child: Text(
                  'log in'.toUpperCase(),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignUpScreen.id);
                },
                child: Text('sign up'.toUpperCase()))
          ],
        ),
      ),
    );
  }
}
