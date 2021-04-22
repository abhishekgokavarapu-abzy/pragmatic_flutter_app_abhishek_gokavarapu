import 'package:flutter/cupertino.dart';

class AppDataProvider extends ChangeNotifier {
  String _authKey;
  String _refreshKey;
  String _username;
  bool _isAdmin = false;
  List<Map<dynamic, dynamic>> _reports;

  saveAuthKey(String authKey) {
    _authKey = authKey;
  }

  saveRefreshKey(String refreshKey) {
    _refreshKey = refreshKey;
  }

  saveUsername(String username) {
    _username = username;
  }

  checkIfAdmin(bool value) {
    _isAdmin = value;
  }

  saveReports(List<Map> reports) {
    _reports = reports;
  }

  get authKey => _authKey;
  get refreshKey => _refreshKey;
  get isAdmin => _isAdmin;
  get getReports => _reports;
  get username => _username;
}
