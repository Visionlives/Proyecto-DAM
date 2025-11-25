import 'package:flutter/material.dart';
import 'package:proyecto_dam/services/auth_services.dart';

class BotonGoogle extends StatelessWidget {
  const BotonGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    AuthServices authServices = AuthServices();
    return FilledButton(
      child: Text('Iniciar Sesión'),
      onPressed: () async {
        try {
          authServices.login();
        } catch (ex) {
          print("ERROR EN BOTON LOGIN: $ex");
        }
      },
    );
  }
}
