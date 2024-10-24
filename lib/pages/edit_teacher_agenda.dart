import 'package:one/helpers/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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
              const Text('Salvo com sucesso!',
                  style: TextStyle(fontSize: 18, color: AppColors.BLACK_TEXT)),
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

class EditTeacherAgenda extends StatefulWidget {
  @override
  _EditTeacherAgendaState createState() => _EditTeacherAgendaState();
}

class _EditTeacherAgendaState extends State<EditTeacherAgenda> {
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
                    'Editar monitorias',
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
                  Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.BLACK_TEXT, width: 1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          'Escreva os horários que têm disponíveis:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: AppColors.BLUE_AGENDA),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  ElevatedButton(
                    onPressed: () {
                      _sendFeedback(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.MEDIUM_COLOR,
                        minimumSize: const Size(262, 55)),
                    child: const Text(
                      'Salvar',
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
