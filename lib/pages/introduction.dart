import 'package:flutter/material.dart';
import 'package:one/helpers/appcolors.dart';
import 'package:one/pages/home.dart';

class IntroductionPage extends StatelessWidget {
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
                'Seja Bem-Vindo',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 36, fontWeight: FontWeight.w300, height: 0.9),
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.home_outlined,
                    size: 30,
                    color: AppColors.DARKER_COLOR,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Tire suas dúvidas',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: AppColors.BLACK_TEXT,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.book_outlined,
                    size: 30,
                    color: AppColors.DARKER_COLOR,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Marque monitoria',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: AppColors.BLACK_TEXT,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.people_alt_outlined,
                    size: 30,
                    color: AppColors.DARKER_COLOR,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Entre em  grupos \nde estudos',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: AppColors.BLACK_TEXT,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.person_outline,
                    size: 30,
                    color: AppColors.DARKER_COLOR,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'E veja seu ranking',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: AppColors.BLACK_TEXT,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(61, 112, 128, 1),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: const Text('Entendi'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
