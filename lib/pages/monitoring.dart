import 'package:flutter/material.dart';
import 'package:one/pages/group.dart';
import 'package:one/pages/home.dart';

class MonitoringPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: const Color.fromRGBO(61, 112, 128, 1),
                  title: const Text(
                    'One',
                    style: TextStyle(
                        fontFamily: "Righteous",
                        fontSize: 24,
                        color: Colors.white),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(253, 253, 253, 1.0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(61, 112, 128, 1),
                    spreadRadius: 12,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Taylor, sua \nmonitoria te \nespera :)',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: "inter",
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C313A),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Disciplinas Existentes',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 24),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         MathematicsPage(), // Substituir pela página correta
                                  //   ),
                                  // );
                                },
                                child: SubjectCard(
                                  title: 'Matemática',
                                  color: Color(0xFFBB4C53),
                                ),
                              ),
                              SizedBox(width: 16),
                              InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         HistoryPage(), 
                                  //   ),
                                  // );
                                },
                                child: SubjectCard(
                                  title: 'História',
                                  color: Color(0xFF7E4987),
                                ),
                              ),
                              SizedBox(width: 16),
                              InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         ScheduleMonitoringPage(), 
                                  //   ),
                                  // );
                                },
                                child: SubjectCard(
                                  title: 'DAD',
                                  color: Color(0xFF305A77),
                                ),
                              ),
                              SizedBox(width: 16),
                              InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         ScheduleMonitoringPage(), 
                                  //   ),
                                  // );
                                },
                                child: SubjectCard(
                                  title: 'Português',
                                  color: Color(0xFFD27051),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Disciplinas que recebo monitoria',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         ScheduleMonitoringPage(), 
                                  //   ),
                                  // );
                                },
                                child: const SubjectCard(
                                  title: 'DAD',
                                  color: Color(0xFF305A77),
                                ),
                              ),
                              const SizedBox(width: 16),
                              InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         ScheduleMonitoringPage(), 
                                  //   ),
                                  // );
                                },
                                child: const SubjectCard(
                                  title: 'Português',
                                  color: Color(0xFFD27051),
                                ),
                              ),
                              const SizedBox(width: 16),
                              InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         ScheduleMonitoringPage(), 
                                  //   ),
                                  // );
                                },
                                child: const SubjectCard(
                                  title: 'Matemática',
                                  color: Color(0xFFBB4C53),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (int index) {
          if (index == 0) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          }
          if (index == 2) {
             Navigator.of(context).push(
               MaterialPageRoute(
                 builder: (context) => GroupPage(),
               ),
             );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        selectedItemColor: const Color.fromRGBO(61, 112, 128, 1),
        unselectedItemColor: Colors.white,
        backgroundColor: const Color.fromRGBO(72, 79, 92, 1.0),
        elevation: 10,
        selectedIconTheme: const IconThemeData(size: 24, weight: 24),
        unselectedIconTheme: const IconThemeData(size: 24, weight: 24),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final String title;
  final Color color;

  const SubjectCard({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
