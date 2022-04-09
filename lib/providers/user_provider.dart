import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttergram/models/user.dart';
import 'package:fluttergram/resourses/auth_methods.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User? get user => _user;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();

    _user = user;
    notifyListeners();
  }
}
