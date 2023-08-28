import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  User? _user;

  User? get user => _user;

  bool get isLoggedIn => _user != null;

  Future<void> login(String username, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: username,
        password: password,
      );
      _user = userCredential.user;
      notifyListeners();
    } catch (e) {
      _errorMessage = "Error: $e";

      scheduleMicrotask(() {
        notifyListeners();
      });
    }
  }

  Future<void> register(String username, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );
      _user = userCredential.user;
      notifyListeners();
    } catch (e) {
      print("Error durante register: $e");
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }
}
