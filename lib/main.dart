import 'package:flutter/material.dart';
import 'package:one/starter.dart';

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
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }
  _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 5), () {});
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StarterPage()),
      );
    });
  }

  // _navigateToLogin() async {
  //   await Future.delayed(const Duration(seconds: 5), () {});
  //   // ignore: use_build_context_synchronously
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => StarterPage()),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 170),
            Image.asset(
              'android/app/src/main/res/drawable/onelogo.png',
              height: 400,
              width: 250,
            ),
            const SizedBox(height: 200),
            Image.asset('android/app/src/main/res/drawable/charging.gif'),
          ],
        ),
      ),
    );
  }
}

