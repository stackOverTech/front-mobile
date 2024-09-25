import 'package:flutter/material.dart';
import 'package:one/pages/introduction.dart';
import 'dart:async';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _isMessageVisible = false;

  @override
  void initState() {
    super.initState();
    _simulateDatabaseCall();
  }

  Future<void> _simulateDatabaseCall() async {
    await Future.delayed(Duration(seconds: 1));
    int status = 200;

    if (status == 200) {
      setState(() {
        _isMessageVisible = true;
      });

      await Future.delayed(Duration(seconds: 5));
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => IntroductionPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      body: Center(
        child: _isMessageVisible
            ? Column(
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
                  Text('Cadastrado com sucesso!', style: TextStyle(fontSize: 24, color: Color(0xFF333333))
                  ),
                ],
              )
            : Container(),
      ),
    );
  }
}
