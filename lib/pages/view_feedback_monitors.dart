import 'package:flutter/material.dart';
import 'package:one/helpers/appcolors.dart';

// subindo as telas

class ViewFeedbackMonitors extends StatefulWidget {
  @override
  _ViewFeedbackMonitorsState createState() => _ViewFeedbackMonitorsState();
}

class _ViewFeedbackMonitorsState extends State<ViewFeedbackMonitors> {
  int _selectedStars = 0;
  final int monitorRate = 4;
  final String disciplinaName = 'DAD';

  @override
  void initState() {
    super.initState();
    _selectedStars = monitorRate;
  }

  void _onStarTap(int index) {
    setState(() {
      _selectedStars = index + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACKGROUND_COLOR,
      body: Column(
        children: [
          const SizedBox(height: 40),
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
                    'android/app/src/main/res/drawable/back_button_grey.png',
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
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.BLACK_TEXT, width: 1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        Text('Monitoria $disciplinaName',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
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
                          'Sua classificação:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () => _onStarTap(index),
                                  child: Image.asset(
                                    index < _selectedStars
                                        ? 'android/app/src/main/res/drawable/star_filled.png'
                                        : 'android/app/src/main/res/drawable/star_null.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                if (index < 4) SizedBox(width: 8),
                              ],
                            );
                          }),
                        ),
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
                    child: const Column(
                      children: [
                        Text(
                          'Feedbacks recebidos: ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Lorem ipsum dolor sit amet consectetur. Ultrices quis felis ut donec eu et orci. Dictum eu nulla consequat euismod. '),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                            'Lorem ipsum dolor sit amet consectetur. Ultrices quis felis ut donec eu et orci. Dictum eu nulla consequat euismod. '),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                            'Lorem ipsum dolor sit amet consectetur. Ultrices quis felis ut donec eu et orci. Dictum eu nulla consequat euismod. '),
                        SizedBox(height: 10),
                        Text(
                            'Lorem ipsum dolor sit amet consectetur. Ultrices quis felis ut donec eu et orci. Dictum eu nulla consequat euismod. '),
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
