import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:one/helpers/appcolors.dart';

class Conect extends StatefulWidget {
  final Widget child;

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
    _checkInitialConnection();
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
    
    // Se estiver conectado, recarregar a tela
    if (conectado) {
      // Isso pode ser uma navegação, ou apenas um setState para reconstruir o widget
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => widget.child),
        (Route<dynamic> route) => false,
      );
    }
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
        backgroundColor: AppColors.BACKGROUND_COLOR,
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
              const SizedBox(height: 30),
              const Text(
                'Ops... Parece que você \nestá sem internet',
                style: TextStyle(fontSize: 24, color: AppColors.HOUR_TEXT),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 120),
              ElevatedButton(
                onPressed: () {
                  _checkInitialConnection();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.MEDIUM_COLOR,
                  minimumSize: const Size(262, 55),
                ),
                child: const Text('Tentar Novamente', style: TextStyle(color: AppColors.BACKGROUND_COLOR)),
              ),
            ],
          ),
        ),
      );
    }

    return widget.child;
  }
}
