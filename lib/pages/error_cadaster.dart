import 'package:flutter/material.dart';
import 'package:one/pages/cadaster.dart';

class ErrorScreen extends StatefulWidget {
  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToCadasterAfterDelay();
  }

  void _navigateToCadasterAfterDelay() {
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CadasterPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Image.asset(
                'android/app/src/main/res/drawable/error.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            Text(
              'Erro ao cadastrar',
              style: TextStyle(fontSize: 24, color: Color(0xFF333333)),
            ),
          ],
        ),
      ),
    );
  }
}
