import 'package:flutter/material.dart';
import 'package:one/helpers/appcolors.dart';
import 'package:one/pages/edit_teacher_agenda.dart';
import 'package:one/pages/view_teacher_agenda.dart';
import 'package:one/pages/view_feedback_monitors.dart';

// subindo as telas

class AddMonitoria extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.DARKER_COLOR,
      body: Column(
        children: [
          const SizedBox(height: 40),
          Stack(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Monitor',
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
                    Navigator.pop(context); // Volta para a página anterior
                  },
                ),
              ),
              const SizedBox(height: 80)
            ],
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.BACKGROUND_COLOR,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                children: [
                  const SizedBox(height: 70),
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.BLACK_TEXT, width: 1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Visualize as monitorias\nagendadas:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewTeacherAgenda()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.MEDIUM_COLOR,
                              minimumSize: const Size(262, 55)),
                          child: const Text(
                            'Ver monitorias',
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
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.BLACK_TEXT, width: 1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Edite sua agenda de monitorias:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditTeacherAgenda()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.MEDIUM_COLOR,
                              minimumSize: const Size(262, 55)),
                          child: const Text(
                            'Editar monitoria',
                            style: TextStyle(
                                color: AppColors.BACKGROUND_COLOR,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.BLACK_TEXT, width: 1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Ver feedbacks: ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewFeedbackMonitors()),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
