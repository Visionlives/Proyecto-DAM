import 'package:flutter/material.dart';
import 'package:proyecto_dam/utils/constantes.dart';
import 'package:proyecto_dam/widgets/boton_google.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(cPrimario), Color(cSecundario)],
          ),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 300, horizontal: 24),
          padding: EdgeInsets.fromLTRB(4, 20, 4, 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(cCuaternario), Color(cTerciario)],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 80),
                child: Text(
                  'Eventos USM',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(),
              // BOTON GOOGLE
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                width: double.infinity,
                child: BotonGoogle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
