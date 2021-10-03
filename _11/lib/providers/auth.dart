import 'dart:async';
import 'dart:convert';

import 'package:_11/models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_token != null && _expiryDate!.isAfter(DateTime.now())) {
      return _token as String;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'v1/accounts:signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'v1/accounts:signInWithPassword');
  }

  Future<void> _authenticate(
    String email,
    String password,
    String unencodedPath,
  ) async {
    final uri = Uri.https(
      'identitytoolkit.googleapis.com',
      unencodedPath,
      {
        'key': 'AIzaSyAB-d9ndGLhjOw_bHF7tpXOC2k0GgqEQwY',
      },
    );
    final response = await http.post(
      uri,
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    print(response.body);
    final responseBody = json.decode(response.body);
    if (responseBody['error'] != null) {
      throw HttpException(responseBody['error']['message']);
    }
    _token = responseBody['idToken'];
    _userId = responseBody['localId'];
    _expiryDate = DateTime.now()
        .add(Duration(seconds: int.parse(responseBody['expiresIn'])));
    _autoLogout();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'token': _token,
      'userId': _userId,
      'expiryDate': _expiryDate?.toIso8601String(),
    });
    prefs.setString('userData', userData);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final userData =
        json.decode(prefs.getString('userData') ?? '') as Map<String, dynamic>;
    final expiryDate = DateTime.parse(userData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = userData['token'];
    _userId = userData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    _authTimer?.cancel();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    notifyListeners();
  }

  void _autoLogout() {
    _authTimer?.cancel();
    _authTimer = null;
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
