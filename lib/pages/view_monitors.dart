import 'package:flutter/material.dart';
import 'package:one/helpers/appcolors.dart';
import 'package:one/pages/feedback_monitors.dart';
import 'package:one/pages/apointmant_monitor.dart';
import 'package:intl/date_symbol_data_local.dart';


void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ViewMonitors(),
    );
  }
}

class ViewMonitors extends StatelessWidget {
  Map<String, dynamic> fetchMonitorInfo() {
    String materia = "DAD";
    String quantidadeMonitores = "4";
    List<String> nomesMonitores = ["Harry", "Olivia", "Bruno", "Bibia"];
    List<String> imagensMonitores = [
      "android/app/src/main/res/drawable/onelogo.png",
      "android/app/src/main/res/drawable/error.png",
      "android/app/src/main/res/drawable/onelogo.png",
      "android/app/src/main/res/drawable/error.png"
    ];

    return {
      'materia': materia,
      'quantidadeMonitores': quantidadeMonitores,
      'nomesMonitores': nomesMonitores,
      'imagensMonitores': imagensMonitores,
    };
  }

  @override
  Widget build(BuildContext context) {
    final monitorInfo = fetchMonitorInfo();

    return Scaffold(
      backgroundColor: AppColors.DARKER_COLOR,
      body: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    monitorInfo['materia'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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
                    Navigator.pop(context); // Volta para a página anterior
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
                  const SizedBox(height: 33),
                  const Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Text(
                      'Selecione o monitor\ndesejado:',
                      style: TextStyle(
                        fontSize: 24,
                        color: AppColors.HOUR_TEXT,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Text(
                      "Monitores (${monitorInfo['quantidadeMonitores']})",
                      style: const TextStyle(
                        fontSize: 24,
                        color: AppColors.HOUR_TEXT,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Lista os monitores com botão encapsulador
                  for (var i = 0; i < monitorInfo['nomesMonitores'].length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          // Navega para a nova página
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ApointmantMonitor(
                                monitorName: monitorInfo['nomesMonitores'][i],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    monitorInfo['imagensMonitores'][i],
                                    width: 38,
                                    height: 38,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    monitorInfo['nomesMonitores'][i],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: AppColors.HOUR_TEXT,
                                    ),
                                  ),
                                ],
                              ),
                              Image.asset(
                                'android/app/src/main/res/drawable/arrow.png',
                                width: 34,
                                height: 34,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.BLACK_TEXT, width: 1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Dê feedback para os monitores:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => FeedbackMonitors()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.MEDIUM_COLOR,
                              minimumSize: const Size(262, 55)),
                          child: const Text(
                            'Feedback',
                            style: TextStyle(
                                color: AppColors.BACKGROUND_COLOR,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  AddDisciplineButton(), // Adicionando o novo botão
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// StatefulWidget para o botão de adicionar disciplina
class AddDisciplineButton extends StatefulWidget {
  @override
  _AddDisciplineButtonState createState() => _AddDisciplineButtonState();
}

class _AddDisciplineButtonState extends State<AddDisciplineButton> {
  bool _isAdded = false; // indica se a materia foi adicionada 

  void _toggleFavorite() {
    setState(() {
      _isAdded = !_isAdded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.BLACK_TEXT, width: 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          const Text(
            'Gostaria de adicionar DAD a aba “Disciplinas que recebo monitoria”?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              _toggleFavorite();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _isAdded ? AppColors.DAD_COLOR : AppColors.DARKER_COLOR,
              minimumSize: const Size(262, 55),
            ),
            child: Text(
              _isAdded ? 'Adicionado' : 'Adicionar',
              style: const TextStyle(
                color: AppColors.BACKGROUND_COLOR,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
