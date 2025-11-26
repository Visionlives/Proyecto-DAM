import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proyecto_dam/services/auth_services.dart';
import 'package:proyecto_dam/utils/constantes.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  AuthServices authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(4, 20, 4, 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(cPrimario), Color(cCuaternario)],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Icon(
                MdiIcons.accountCircleOutline,
                size: 100,
                color: Color(cSecundario),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Nombre: ${authServices.getCurrentUser()?.displayName.toString()}',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Correo: ${authServices.getCurrentUser()?.email.toString()}',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 100),
          child: Column(
            children: [
              Text(
                "Gestor de eventos USM",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "Versión 1.0.0",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        Container(
          width: double.infinity,
          child: FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Color(cCuaternario)),
            child: Text(
              'Cerrar Sesión',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
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
    );
  }
}
