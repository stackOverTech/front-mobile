import 'package:one/helpers/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ViewTeacherAgenda extends StatefulWidget {
  @override
  _ViewTeacherAgendaState createState() => _ViewTeacherAgendaState();
}

class _ViewTeacherAgendaState extends State<ViewTeacherAgenda> {
  DateTime selectedDay = DateTime.now();
  String? selectedTime;

  String _formatMonth(DateTime date) {
    List<String> months = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  Map<String, dynamic> fetchMonitorInfo() {
    List<String> nomesAlunos = ["Bibia", "Luccas", "Felipe"];
    List<String> horariosAgendados = [
      "20/10 10h até 11h",
      "20/10 11h até 12h",
      "21/10 10h até 11h"
    ];
    List<String> imagensAlunos = [
      "android/app/src/main/res/drawable/onelogo.png",
      "android/app/src/main/res/drawable/error.png",
      "android/app/src/main/res/drawable/onelogo.png",
      "android/app/src/main/res/drawable/error.png"
    ];

    return {
      'nomesAlunos': nomesAlunos,
      'imagensAlunos': imagensAlunos,
      'horariosAgendados': horariosAgendados
    };
  }

  @override
  Widget build(BuildContext context) {
    // Obtenha os dados dos monitores
    var monitorInfo = fetchMonitorInfo();

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
                    'Agenda de monitorias',
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
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.BLACK_TEXT, width: 1),
                      color: AppColors.BLACK_TEXT,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TableCalendar(
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      focusedDay: selectedDay,
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          this.selectedDay = selectedDay;
                        });
                      },
                      selectedDayPredicate: (day) {
                        return isSameDay(selectedDay, day);
                      },
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleTextStyle: TextStyle(
                          color: AppColors.BACKGROUND_COLOR,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      calendarStyle: const CalendarStyle(
                        defaultTextStyle:
                            TextStyle(color: AppColors.BACKGROUND_COLOR),
                        selectedTextStyle:
                            TextStyle(color: AppColors.BACKGROUND_COLOR),
                        todayTextStyle:
                            TextStyle(color: AppColors.BACKGROUND_COLOR),
                      ),
                      onPageChanged: (focusedDay) {
                        setState(() {
                          selectedDay = focusedDay;
                        });
                      },
                      calendarBuilders: CalendarBuilders(
                        headerTitleBuilder: (context, day) {
                          return Center(
                            child: Text(
                              _formatMonth(day),
                              style: const TextStyle(
                                color: AppColors.BACKGROUND_COLOR,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Exibir a lista dos monitores
                  for (var i = 0; i < monitorInfo['nomesAlunos'].length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
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
                                    monitorInfo['imagensAlunos'][i],
                                    width: 38,
                                    height: 38,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    monitorInfo['nomesAlunos'][i],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: AppColors.HOUR_TEXT,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                monitorInfo['horariosAgendados'][i],
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: AppColors.HOUR_TEXT,
                                ),
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
