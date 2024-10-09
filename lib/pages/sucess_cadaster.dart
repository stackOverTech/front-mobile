import 'package:flutter/material.dart';
import 'package:one/pages/introduction.dart';

// subindo as telas 

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToIntroductionAfterDelay();
  }

  void _navigateToIntroductionAfterDelay() {
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => IntroductionPage()),
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
                'android/app/src/main/res/drawable/task_alt.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            Text(
              'Cadastrado com sucesso!',
              style: TextStyle(fontSize: 24, color: Color(0xFF333333)),
            ),
          ],
        ),
      ),
    );
  }
}
