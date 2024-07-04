import 'package:flutter/material.dart';
import 'package:one/cadaster.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 5), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 170),
            Image.asset('android/app/src/main/res/drawable/onelogo.png', height: 400, width: 250,),
            const SizedBox(height: 200),
            Image.asset('android/app/src/main/res/drawable/charging.gif'),
          ],
        ),
      ),
    );
  }
}

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
                'Sua jornada\ncomeça aqui',
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
                  foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(211, 0, 0, 0))
                ),
                child: const Text('Já tem uma conta? Faça seu login'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadasterPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(61, 112, 128, 1),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: const Text('Continuar'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: const Text(
                    'Ajuda',
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
