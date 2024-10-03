import 'package:flutter/material.dart';
import 'package:one/pages/create_group.dart';
import 'package:one/pages/home.dart';
import 'package:one/pages/monitoring.dart';
import 'package:one/pages/group_details.dart';

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
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
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
                      fontWeight: FontWeight.w600,
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
                    leading: const CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage(
                          'android/app/src/main/res/drawable/grupodeestudos.png'),
                    ),
                    title: const Text(
                      'grupo dos estudiosos',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: const Text('DAD'),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 24,
                      color: Color.fromRGBO(61, 112, 128, 1),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GroupDetailsPage(),
                        ),
                      );
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
                      radius: 24,
                      backgroundImage: AssetImage(
                          'android/app/src/main/res/drawable/grupodeestudos.png'),
                    ),
                    title: const Text(
                      'grupo dos estudiosos',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: const Text('DAD'),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 24,
                      color: Color.fromRGBO(61, 112, 128, 1),
                    ),
                    onTap: () {
                       Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GroupDetailsPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage(
                          'android/app/src/main/res/drawable/osbrabosdojava.png'),
                    ),
                    title: const Text(
                      'os brabos do java',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: const Text('POO'),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 24,
                      color: Color.fromRGBO(61, 112, 128, 1),
                    ),
                    onTap: () {
                       Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GroupDetailsPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage(
                          'android/app/src/main/res/drawable/thebrabos.png'),
                    ),
                    title: const Text(
                      'the brabos',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: const Text('Inglês'),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 24,
                      color: Color.fromRGBO(61, 112, 128, 1),
                    ),
                    onTap: () {
                       Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GroupDetailsPage(),
                        ),
                      );
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
            padding: const EdgeInsets.only(right: 60.0),
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 120),
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CreateGroupPage(),
                        ),
                      );
                },
                backgroundColor: Colors.grey[600],
                foregroundColor: Colors.white,
                label: const Text(
                  'Crie um grupo',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
          Positioned(
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CreateGroupPage(),
                        ),
                      );
              },
              backgroundColor: const Color.fromRGBO(61, 112, 128, 1),
              child: const Icon(
                Icons.add,
                color: Colors.white, // Cor do ícone "+"
              ),
              shape: const CircleBorder(),
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
