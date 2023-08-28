import 'package:flutter/material.dart';
import 'package:pokedex/providers/login_provider.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();

  String? errorMessage = '';

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  _printText() {
    print('El texto del usuario es: ${_usernameController.text}');
    print('El texto de la contraseña es: ${_passwordController.text}');
  }

  @override
  void initState() {
    _usernameController.addListener(_printText);
    _passwordController.addListener(_printText);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Ingrese un usuario',
              labelText: 'Usuario',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "El usuario es requerido";
              }
              return null;
            },
            controller: _usernameController,
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              hintText: 'Ingrese una contraseña',
              labelText: 'Contraseña',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "La contraseña es requerido";
              }
              return null;
            },
            controller: _passwordController,
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await _loginProvider.login(
                    _usernameController.text, _passwordController.text);
                print(_loginProvider.errorMessage);
                setState(() {
                  errorMessage = _loginProvider.errorMessage;
                });
                if (_loginProvider.user != null) {
                  Navigator.pushReplacementNamed(context, '/inicio');
                }
              }
            },
            child: const Text('Login'),
          ),
          const SizedBox(height: 20.0),
          if (errorMessage != null)
            Text(
              errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }
}
