import 'package:flutter/material.dart';
import 'package:one/helpers/appcolors.dart';


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
              const Text('Saldo com sucesso!', style: TextStyle(fontSize: 18, color: AppColors.BLACK_TEXT)),
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

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.DARKER_COLOR,
      body: Column(
        children: [
          Stack(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Editar Perfil',
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
                  const SizedBox(height: 30),
                  const Text(
                    'Username',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const TextField(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: AppColors.BLUE_AGENDA),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Bio',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: AppColors.BLUE_AGENDA),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Turma',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: <String>['Turma A', 'Turma B', 'Turma C']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {},
                  ),
                  const SizedBox(height: 30),
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
