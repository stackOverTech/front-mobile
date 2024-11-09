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
    _initializeConnectivity();
  }

  Future<void> _initializeConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    _updateConnectivityStatus(result);

    subscription =
        Connectivity().onConnectivityChanged.listen(_updateConnectivityStatus);
  }

  void _updateConnectivityStatus(ConnectivityResult result) {
    final conectado = result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi;
    if (conectado != isConnected) {
      setState(() {
        isConnected = conectado;
      });
    }
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isConnected ? widget.child : _buildNoInternetScreen();
  }

  Widget _buildNoInternetScreen() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.BACKGROUND_COLOR,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset(
                  'android/app/src/main/res/drawable/wifi.png',
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
                onPressed: () async {
                  final result = await Connectivity().checkConnectivity();
                  _updateConnectivityStatus(result);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.MEDIUM_COLOR,
                  minimumSize: const Size(262, 55),
                ),
                child: const Text('Tentar Novamente',
                    style: TextStyle(color: AppColors.BACKGROUND_COLOR)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
