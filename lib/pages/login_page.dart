import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proyecto_dam/widgets/boton_google.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  String msgError = '';

  @override
  Widget build(BuildContext context) {
    // return Container(child: Text('Login Page BRO'));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.yellow.shade700, Color(0xFF051E34)],
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
            color: Color(0xAAFFFFFF),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 180, horizontal: 20),
            color: Colors.white,
            child: ListView(
              children: [
                Icon(MdiIcons.google, color: Colors.yellow.shade800, size: 70),
                //boton
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  width: double.infinity,
                  child: BotonGoogle(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
