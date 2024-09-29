import 'package:flutter/material.dart';
import 'package:one/helpers/appcolors.dart';
import 'package:one/pages/sucess_cadaster.dart';
import 'package:one/pages/error_cadaster.dart';

class CadasterPage extends StatelessWidget {
  Future<bool> _simulateRegistration() async {
    await Future.delayed(Duration(seconds: 2));
    return true; // Simulando o envio dos dados para o DB e retornando true
  }

  void _register(BuildContext context) async {
    bool isSuccess = await _simulateRegistration();

    if (isSuccess) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NotificationScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ErrorScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        shadowColor: const Color.fromARGB(0, 0, 0, 0),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Cadastro',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nome *',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(61, 112, 128, 1),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Username',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Bio',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            const Text(
              'Turma *',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: <String>['Turma A', 'Turma B', 'Turma C'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {},
            ),
            const SizedBox(height: 96),
            Center(
              child: ElevatedButton(
                onPressed: () => _register(context), // Chama a função de registro
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(61, 112, 128, 1),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Cadastrar', style: TextStyle(color: AppColors.BACKGROUND_COLOR),),
              ),
            ),
            const Spacer(),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Ajuda',
                  style: TextStyle(
                      color: AppColors.LIGHT_COLOR,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
