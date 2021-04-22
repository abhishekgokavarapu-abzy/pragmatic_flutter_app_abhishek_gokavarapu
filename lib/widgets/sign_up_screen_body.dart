import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pragmatic_test_flutter_app/screens/loading_screen.dart';
import 'package:pragmatic_test_flutter_app/screens/login_screen.dart';
import 'package:pragmatic_test_flutter_app/screens/sign_up_screen.dart';

import '../utils/constants/app_constants.dart';
import '../utils/services/rest_api_service.dart';

class SignUpScreenBody extends StatefulWidget {
  @override
  _SignUpScreenBodyState createState() => _SignUpScreenBodyState();
}

class _SignUpScreenBodyState extends State<SignUpScreenBody> {
  String username;
  String emailAddress;
  String password;
  bool isAdmin;
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
              onChanged: (value) {
                username = value.trim();
              },
              decoration: InputDecoration(hintText: 'Enter Desired Username'),
            ),
            TextField(
              onChanged: (value) {
                emailAddress = value.trim();
              },
              decoration: InputDecoration(hintText: 'Enter Email Address'),
            ),
            TextField(
              onChanged: (value) {
                password = value.trim();
              },
              obscureText: true,
              decoration: InputDecoration(hintText: 'Create Password'),
            ),
            // CheckboxListTile(
            //   value: false,
            //   onChanged: (value) {
            //     isAdmin = value;
            //   },
            //   title: Text('is Admin?'),
            // ),
            TextButton(
                onPressed: () async {
                  if ((username == null || emailAddress == null) ||
                      password == null) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                            title: Text('Fields must not be left blank')));
                  } else {
                    Navigator.pushNamed(context, LoadingScreen.id);
                    var responseData = await ApiService.createUser(
                        username, emailAddress, password);
                    if (responseData.statusCode != 201) {
                      print(responseData.body);
                      print(responseData.statusCode);
                      Navigator.pushNamed(context, SignUpScreen.id);
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                              title: Text('Invalid Format - Try gain!!')));
                    } else {
                      Map decodedResponse = jsonDecode(responseData.body);
                      print(decodedResponse);
                      Navigator.pushNamed(context, LoginScreen.id);
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                              title: Text(
                                  'Account Created Successfully - Login Now')));
                    }
                  }
                },
                child: Text(
                  'create'.toUpperCase(),
                )),
          ],
        ),
      ),
    );
  }
}
