import 'package:flutter/material.dart';
import 'package:one/helpers/appcolors.dart';


class ViewProfile extends StatelessWidget {
  final int age = 17;
  final String name = 'harry'; // Correção: Renomeei a variável para 'name'
  final String turma = '3°D Tech';
  final String comments = 'Amo estudar e cantar';
  final String mostAnswer = '4° harry';
  final String materia = 'DAD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.DARKER_COLOR,
      body: Column(
        children: [
          Stack(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Ver Perfil',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.BACKGROUND_COLOR,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 6,
                child: IconButton(
                  icon: Image.asset(
                    'android/app/src/main/res/drawable/back_button.png',
                    width: 40,
                    height: 40,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.BACKGROUND_COLOR,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.0),
                  topRight: Radius.circular(32.0),
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                children: [
                  const SizedBox(height: 20),
                  const Center(
                    child: CircleAvatar(
                      radius: 75,
                      backgroundImage: AssetImage(
                          'android/app/src/main/res/drawable/onelogo.png'),
                      backgroundColor: AppColors.BACKGROUND_COLOR,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Center(
                    child: Text(
                      name,
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Monitor $materia',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.BLACK_TEXT, width: 1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '$age anos',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          turma,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          comments,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.BLACK_TEXT, width: 1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Perguntas Mais Respondidas',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          mostAnswer,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
