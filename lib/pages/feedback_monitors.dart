import 'package:flutter/material.dart';
import 'package:one/helpers/appcolors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FeedbackMonitors(),
    );
  }
}

class FeedbackMonitors extends StatelessWidget {
  Map<String, dynamic> fetchMonitorInfo() {
    String materia = "DAD";
    List<String> nomesMonitores = [
      "Harry",
      "Olivia",
      "Bruno",
      "Bibia",
      "Harry",
      "Olivia",
      "Bruno",
      "Bibia"
    ];
    List<String> imagensMonitores = [
      "android/app/src/main/res/drawable/onelogo.png",
      "android/app/src/main/res/drawable/error.png",
      "android/app/src/main/res/drawable/onelogo.png",
      "android/app/src/main/res/drawable/error.png",
      "android/app/src/main/res/drawable/onelogo.png",
      "android/app/src/main/res/drawable/error.png",
      "android/app/src/main/res/drawable/onelogo.png",
      "android/app/src/main/res/drawable/error.png"
    ];

    return {
      'materia': materia,
      'nomesMonitores': nomesMonitores,
      'imagensMonitores': imagensMonitores,
    };
  }

  @override
  Widget build(BuildContext context) {
    final monitorInfo = fetchMonitorInfo();

    return Scaffold(
      backgroundColor: AppColors.BACKGROUND_COLOR,
      body: Column(
        children: [
          Stack(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Feedback monitoria',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.BLACK_TEXT,
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
                    'android/app/src/main/res/drawable/back_button_light.png',
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
          const SizedBox(height: 60),
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
                              builder: (context) => MonitorDetailPage(
                                monitorName: monitorInfo['nomesMonitores'][i],
                                disciplinasName: monitorInfo['materia'],
                                monitorImage: monitorInfo['imagensMonitores'][i],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: AppColors.BACKGROUND_COLOR,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Página de feedback do monitor
class MonitorDetailPage extends StatefulWidget {
  final String monitorName;
  final String disciplinasName;
  final String monitorImage;

  MonitorDetailPage({
    required this.monitorName,
    required this.disciplinasName,
    required this.monitorImage,
  });

  @override
  _MonitorDetailPageState createState() => _MonitorDetailPageState();
}

class _MonitorDetailPageState extends State<MonitorDetailPage> {
  int _selectedStars = 0;
  final TextEditingController _feedbackController = TextEditingController();

  void _onStarTap(int index) {
    setState(() {
      _selectedStars = index + 1;
    });
  }

void _sendFeedback(BuildContext context) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 50,
      right: 0,
      child: Material(
        elevation: 6.0,
        child: Container(
          color: AppColors.BACKGROUND_COLOR,
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset(
                'android/app/src/main/res/drawable/task_alt.png',
                width: 38,
                height: 38,
              ),
              const SizedBox(width: 8),
              const Text('Enviado com sucesso!', style: TextStyle(fontSize: 18, color: AppColors.BLACK_TEXT)),
            ],
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 3), () {
    overlayEntry.remove();
    Navigator.pop(context);
  });
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACKGROUND_COLOR,
      body: Column(
        children: [
          Stack(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Feedback monitoria',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.BLACK_TEXT,
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
                    'android/app/src/main/res/drawable/back_button_light.png',
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
                  const SizedBox(height: 33),
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Image.asset(
                      widget.monitorImage,
                      width: 144,
                      height: 144,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(widget.monitorName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  Text('Monitor ${widget.disciplinasName}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500)),
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
                          'Classifique o quanto achou a\naula boa:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return GestureDetector(
                              onTap: () => _onStarTap(index),
                              child: Image.asset(
                                index < _selectedStars
                                    ? 'android/app/src/main/res/drawable/star_filled.png'
                                    : 'android/app/src/main/res/drawable/star_null.png',
                                width: 24,
                                height: 24,
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 10),
                      ],
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
                          'Deixe seu feedback para esse\nmonitor (elogios, pontos de\nmelhoria...)',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _feedbackController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: AppColors.BLUE_AGENDA),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _sendFeedback(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.DARKER_COLOR,
                        minimumSize: const Size(262, 55)),
                    child: const Text(
                      'Enviar',
                      style: TextStyle(
                          color: AppColors.BACKGROUND_COLOR,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
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
