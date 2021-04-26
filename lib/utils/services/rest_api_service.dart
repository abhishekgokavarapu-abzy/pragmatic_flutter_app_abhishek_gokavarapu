import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String BASE_URL = 'rise-app-staging.herokuapp.com';

  static Future<http.Response> obtainAccessRefreshToken(
          String username, String password) =>
      http.post(
          Uri.https(
            BASE_URL,
            'auth/login',
          ),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              <String, String>{'username': username, 'password': password}));

  static Future<http.Response> createUser(
          String username, String emailAddress, String password) =>
      http.post(
          Uri.https(
            BASE_URL,
            'auth/register',
          ),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'username': username,
            'email': emailAddress,
            'password': password,
            "password2": password,
            "first_name": "fName - $username",
            "last_name": "lName - $username",
          }));

  static Future<http.Response> getReports(String authKey) => http.get(
        Uri.https(
          BASE_URL,
          'reports',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authKey',
        },
      );

  static Future<http.Response> updateReportStatus(
          String authKey, String id, String reportStatus) =>
      http.patch(
          Uri.https(
            BASE_URL,
            'reports/$id/',
          ),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $authKey',
          },
          body: jsonEncode(<String, String>{
            'status': reportStatus,
          }));

  static Future<http.Response> uploadImage(
          String base64Image, String imageName) =>
      http.post(
          Uri.https(
            BASE_URL,
            'imagesb64/',
          ),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{'image': base64Image}));

  static Future<http.Response> createReport(
          String title, String description, String images) =>
      http.post(
          Uri.https(
            BASE_URL,
            'reports/',
          ),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'title': title,
            'description': description,
            'status': 'PENDING',
            'images': images,
          }));
}
