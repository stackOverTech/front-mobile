import 'package:flutter/material.dart';
import 'package:one/home.dart';
class LoginPage extends StatelessWidget {
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
                'Pronto para\naprender?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w400, height: 0.9),
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
                  foregroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(211, 0, 0, 0))
                ),
                child: const Text('Não tem uma conta? Cadastre-se'),
              ),
              const SizedBox(height: 20),
              DefaultBtn(text: "Entrar", page: HomePage()),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => HomePage()),
              //     );
              //   },
              // style: ElevatedButton.styleFrom(
              //   backgroundColor: const Color.fromRGBO(61, 112, 128, 1),
              //   minimumSize: const Size(double.infinity, 50),
              // ),
              //   child: const Text('Entrar'),
              // ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: const Text(
                    'Esqueci minha senha',
                    style: TextStyle(
                      color: Color.fromRGBO(61, 112, 128, 1),
                      decoration: TextDecoration.underline
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DefaultBtn extends StatelessWidget{
  final String text;
  final StatelessWidget page;

  DefaultBtn({
    required this.text,
    required this.page
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(61, 112, 128, 1),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(text),
    );
  }
}