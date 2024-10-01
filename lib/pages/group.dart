import 'package:flutter/material.dart';
import 'package:one/pages/home.dart';
import 'package:one/pages/monitoring.dart';

class GroupPage extends StatelessWidget {
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
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  const Text(
                    'Entre em um grupo \nde estudos :)',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: "inter",
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2C313A),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Grupos que você já participa
                  const Text(
                    'Grupos que você já participa (1)',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: "inter"),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                          'android/app/src/main/res/drawable/grupodeestudos.png'),
                    ),
                    title: const Text('grupo dos estudiosos'),
                    subtitle: const Text('DAD'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Ação ao clicar no grupo
                    },
                  ),
                  const SizedBox(height: 24),

                  // Grupos que você ainda não participa
                  const Text(
                    'Grupos que você ainda não participa (3)',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: "inter"),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                          'android/app/src/main/res/drawable/grupodeestudos.png'),
                    ),
                    title: const Text('grupo dos estudiosos'),
                    subtitle: const Text('DAD'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Ação ao clicar no grupo
                    },
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                          'android/app/src/main/res/drawable/osbrabosdojava.png'),
                    ),
                    title: const Text('os brabos do java'),
                    subtitle: const Text('POO'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Ação ao clicar no grupo
                    },
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                          'android/app/src/main/res/drawable/thebrabos.png'),
                    ),
                    title: const Text('the brabos'),
                    subtitle: const Text('Inglês'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Ação ao clicar no grupo
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 70.0),
            child: FloatingActionButton.extended(
              onPressed: () {
                // Ação ao criar grupo
              },
              backgroundColor: Colors.grey[600],
              foregroundColor: Colors.white,
              label: const Text('Crie um grupo'),
              icon: const SizedBox(),
            ),
          ),
          Positioned(
            right: 8,
            child: FloatingActionButton(
              onPressed: () {
                // Ação ao clicar no +
              },
              backgroundColor: const Color.fromRGBO(
                  61, 112, 128, 1), // Cor do botão circular
              child: const Icon(Icons.add), // Ícone de "+"
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (int index) {
          if (index == 0) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          }
          if (index == 1) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MonitoringPage(),
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
