import 'package:flutter/material.dart';

class GroupDetailsPage extends StatefulWidget {
  @override
  _GroupDetailsPageState createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage> {
  String buttonText = 'Entrar no grupo'; 
  Color buttonColor = const Color.fromRGBO(61, 112, 128, 1); 

  void _toggleButton() {
    setState(() {
      if (buttonText == 'Entrar no grupo') {
        buttonText = 'Sair do grupo'; 
        buttonColor = Colors.grey; 
      } else {
        buttonText = 'Entrar no grupo'; 
        buttonColor = const Color.fromRGBO(61, 112, 128, 1); 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: 110,
                backgroundColor: const Color.fromRGBO(61, 112, 128, 1),
                leading: IconButton(
                  icon: Image.asset(
                      'android/app/src/main/res/drawable/back_button.png'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24.0),
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
                  const SizedBox(height: 20),
                  Center(
                    child: const Text(
                      'grupo dos estudiosos',
                      style: TextStyle(
                        fontSize: 26,
                        fontFamily: "inter",
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C313A),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Detalhes do grupo',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: "inter",
                    ),
                  ),
                  const SizedBox(height: 8),
                  const ListTile(
                    title: Text(
                      'Lorem ipsum dolor sit amet, conse ctetur adipisci elit, sed eiusmod tempor incidunt ut',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Dias de encontro',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: "inter",
                    ),
                  ),
                  const SizedBox(height: 8),
                  const ListTile(
                    title: Text(
                      'Lorem ipsum dolor sit amet, conse ctetur ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Integrantes',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: "inter",
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(61, 112, 128, 1),
                            shape: BoxShape.circle,
                          ),
                        ),
                        title: const Text(
                          'Integrante 1',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(61, 112, 128, 1),
                            shape: BoxShape.circle,
                          ),
                        ),
                        title: const Text(
                          'Integrante 2',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(61, 112, 128, 1),
                            shape: BoxShape.circle,
                          ),
                        ),
                        title: const Text(
                          'Integrante 3',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
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
            padding: const EdgeInsets.only(right: 70.0, bottom: 30.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 240),
              child: FloatingActionButton.extended(
                onPressed: _toggleButton,
                backgroundColor: buttonColor,
                foregroundColor: Colors.white,
                label: Text(
                  buttonText,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
