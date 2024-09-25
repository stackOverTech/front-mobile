import 'package:flutter/material.dart';
import 'package:one/login.dart';
import 'package:one/signup.dart';

class StarterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('android/app/src/main/res/drawable/onelogo.png', height: 220),
              const SizedBox(height: 30),
              const Text(
                'Entre em\numa\ncomunidade\nde estudos',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w400, height: 0.9),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(211, 0, 0, 0)),
                ),
                child: const Text('Crie uma conta ou entre em\n          uma já existente.'),
              ),
              const SizedBox(height: 40),
              DefaultBtn(text: "Cadastrar", page: SignUpPage()),
              const SizedBox(height: 20),
              DefaultBtn(text: "Entrar", page: LoginPage()),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}