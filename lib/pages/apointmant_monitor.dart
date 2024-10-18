import 'package:one/helpers/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// subindo as telas

class ApointmantMonitor extends StatefulWidget {
  final String monitorName;

  ApointmantMonitor({required this.monitorName});

  @override
  _ApointmantMonitorState createState() => _ApointmantMonitorState();
}

class _ApointmantMonitorState extends State<ApointmantMonitor> {
  DateTime selectedDay = DateTime.now();
  String? selectedTime;

  void _sendFeedback(BuildContext context) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        right: 0,
        left: 0,
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
                const Text(
                  'Agendado com sucesso!',
                  style: TextStyle(fontSize: 18, color: AppColors.BLACK_TEXT),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
      Navigator.pop(context);
    });
  }

  List<Widget> _buildTimeOptions() {
    List<String> times = ['10h-11h', '12h-13h', '14h-15h'];

    return times.map((time) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio<String>(
            value: time,
            groupValue: selectedTime,
            onChanged: (value) {
              setState(() {
                selectedTime = value;
              });
            },
            activeColor: AppColors.DARKER_COLOR,
          ),
          Text(
            time,
            style: const TextStyle(color: AppColors.BLACK_TEXT, fontSize: 16),
          ),
        ],
      );
    }).toList();
  }

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
                    'Agenda do monitor',
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
                  const SizedBox(height: 40),
                  const Text(
                    'Selecione o dia desejado: ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.BLACK_TEXT, width: 1),
                      color: AppColors.BLACK_TEXT,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 350, 
                    child: TableCalendar(
                      locale: 'pt_BR',
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
                      headerStyle: HeaderStyle(
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
                              style: TextStyle(
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
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.BLACK_TEXT, width: 1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Horários disponíveis no dia\nselecionado:',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        ..._buildTimeOptions(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _sendFeedback(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.DARKER_COLOR,
                      minimumSize: const Size(262, 55),
                    ),
                    child: const Text(
                      'Agendar',
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
