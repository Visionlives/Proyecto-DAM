import 'package:flutter/material.dart';
import 'package:proyecto_dam/services/auth_services.dart';

class AgregarEventoPage extends StatefulWidget {
  const AgregarEventoPage({super.key});

  @override
  State<AgregarEventoPage> createState() => _AgregarEventoPageState();
}

class _AgregarEventoPageState extends State<AgregarEventoPage> {
  AuthServices authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Agregar Eventos'),
          Spacer(),
          Container(
            width: double.infinity,
            child: FilledButton(
              child: Text('Cerrar Sesión'),
              onPressed: () async {
                try {
                  authServices.logout();
                } catch (ex) {
                  print("ERROR EN BOTON LOGOUT: $ex");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
