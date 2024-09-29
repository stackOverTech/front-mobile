import 'package:flutter/material.dart';
import 'package:one/pages/cadaster.dart';
import 'package:one/helpers/appcolors.dart';

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
    Future.delayed(const Duration(seconds: 5), () {
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
      backgroundColor: AppColors.BACKGROUND_COLOR,
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
            const SizedBox(height: 30),
            const Text(
              'Erro ao cadastrar',
              style: TextStyle(fontSize: 24, color: AppColors.HOUR_TEXT),
            ),
          ],
        ),
      ),
    );
  }
}
