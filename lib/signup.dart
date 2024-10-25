import 'package:flutter/material.dart';
import 'package:one/pages/cadaster.dart';
import 'package:one/pages/login.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('android/app/src/main/res/drawable/onelogo.png',
                  height: 220),
              const SizedBox(height: 30),
              const Text(
                'Sua jornada\ncomeça aqui',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 36, fontWeight: FontWeight.w400, height: 0.9),
              ),
              const SizedBox(height: 48),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Color.fromRGBO(61, 112, 128, 1)),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(color: Color.fromRGBO(61, 112, 128, 1)),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(211, 0, 0, 0))),
                child: const Text('Já tem uma conta? Faça seu login'),
              ),
              const SizedBox(height: 20),
              DefaultBtn(text: "Continuar", page: CadasterPage()),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Ajuda',
                  style: TextStyle(
                      color: Color.fromRGBO(61, 112, 128, 1),
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
