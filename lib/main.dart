import 'package:flutter/material.dart';
import 'package:one/pages/cadaster.dart';
import 'package:one/pages/login.dart';
import 'package:one/starter.dart';
import 'package:one/pages/conect.dart';
import 'package:one/helpers/appcolors.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Conect(
        child: SplashScreen(),
      ),
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
<<<<<<< HEAD

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StarterPage()),
      );
    });
=======
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => StarterPage()),
    );
>>>>>>> 9e987e29a555d9f6856f7765403d52f7f7aedd74
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
            const SizedBox(height: 100),
            Image.asset('android/app/src/main/res/drawable/charging.gif'),
          ],
        ),
      ),
    );
  }
}
