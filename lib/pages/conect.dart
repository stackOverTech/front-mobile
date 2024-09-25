import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class Conect extends StatefulWidget {
  final Widget child; // Widget que será envolvido pelo Conect

  const Conect({Key? key, required this.child}) : super(key: key);

  @override
  _ConectState createState() => _ConectState();
}

class _ConectState extends State<Conect> {
  late StreamSubscription<ConnectivityResult> subscription;
  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    // Checa a conectividade inicial
    _checkInitialConnection();
    // Escuta mudanças de conectividade
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      verificarConexao(result);
    });
  }

  Future<void> _checkInitialConnection() async {
    var result = await Connectivity().checkConnectivity();
    verificarConexao(result);
  }

  void verificarConexao(ConnectivityResult result) {
    bool conectado = (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi);
    setState(() {
      isConnected = conectado;
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isConnected) {
      return Scaffold(
        backgroundColor: Color(0xFFF0F0F0),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset(
                  'android/app/src/main/res/drawable/error.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Ops... Parece que você está sem internet',
                style: TextStyle(fontSize: 24, color: Color(0xFF555555)),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _checkInitialConnection();
                },
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(61, 112, 128, 1),
                minimumSize: const Size(double.infinity, 50),
              ),
                child: Text('Tentar Novamente'),
              ),
            ],
          ),
        ),
      );
    }

    return widget.child;
  }
}
