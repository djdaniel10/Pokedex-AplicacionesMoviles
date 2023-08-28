import 'package:flutter/material.dart';
import 'package:pokedex/widgets/login.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/';
  
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginWidget(),
          ],
        ),
      ),
    );
  }
}

