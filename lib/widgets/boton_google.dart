import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proyecto_dam/services/auth_services.dart';
import 'package:proyecto_dam/utils/constantes.dart';

class BotonGoogle extends StatelessWidget {
  const BotonGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    AuthServices authServices = AuthServices();
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: Color(cPrimario),
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 18),
        padding: EdgeInsets.symmetric(vertical: 12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [Colors.amber, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: Icon(MdiIcons.google, color: Colors.white, size: 40),
          ),
          Text(
            'Iniciar Sesión',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
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
