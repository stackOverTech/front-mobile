import 'package:flutter/material.dart';

class CreateGroupPage extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroupPage> {
  String buttonText = 'Criar';
  Color buttonColor = const Color.fromRGBO(61, 112, 128, 1);
  final TextEditingController _groupNameController = TextEditingController();

  void _toggleButton() {
    setState(() {
      if (buttonText == 'Criar') {
        buttonText = 'Sair do grupo';
        buttonColor = Colors.grey;
      } else {
        buttonText = 'Criar';
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: <Widget>[
                        const CircleAvatar(
                          radius: 75,
                          backgroundImage: AssetImage(
                              'android/app/src/main/res/drawable/onelogo.png'),
                          backgroundColor: Colors.transparent,
                        ),
                        IconButton(
                          icon: const Icon(Icons.camera_alt),
                          iconSize: 30,
                          color: Colors.white,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Trocar foto de perfil'),
                                content: const Text(
                                    'Você pode trocar a foto de perfil aqui.'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Nome do grupo',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: "inter",
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _groupNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Digite o nome do grupo',
                      filled: true,
                      fillColor: Colors.white,
                    ),
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
