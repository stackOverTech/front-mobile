import 'package:flutter/material.dart';
import 'package:one/home.dart';

class MonitoringPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Cabeçalho com o nome do usuário e saudação
          Container(
            padding: EdgeInsets.all(16.0),
            color: const Color.fromRGBO(61, 112, 128, 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  automaticallyImplyLeading: false, // remove o botão de back
                  backgroundColor: const Color.fromRGBO(61, 112, 128, 1),
                  elevation: 0,
                  title: const Text(
                    'One',
                    style: TextStyle(
                      fontFamily: "Righteous",
                      fontSize: 24,
                      color: Colors.white
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Taylor, sua monitoria te espera :)',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Disciplinas existentes
          Padding(
            padding: const EdgeInsets.all(16.0),
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
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SubjectCard(
                      title: 'Matemática',
                      color: Colors.redAccent,
                    ),
                    SubjectCard(
                      title: 'História',
                      color: Colors.purpleAccent,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Disciplinas que recebe monitoria
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Disciplinas que recebo monitoria',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SubjectCard(
                      title: 'DAD',
                      color: Colors.blueAccent,
                    ),
                    SubjectCard(
                      title: 'Português',
                      color: Colors.orangeAccent,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            1, 
        onTap: (int index) {
          if (index == 0) {
            // Verifica se o item "home" foi clicado
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    HomePage(), 
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
        type: BottomNavigationBarType.fixed
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
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}