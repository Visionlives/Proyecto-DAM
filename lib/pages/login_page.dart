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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple, Colors.amber],
          ),
        ),
        child: Container(          
          decoration: BoxDecoration(
            color: Color.fromARGB(78, 255, 255, 255),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 200, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListView(
              children: [
                Text('Inicia Sesion', textAlign: TextAlign.center, style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber
                    ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 105),
                ),                                  
                ShaderMask
                (shaderCallback: (Rect bounds)
                {
                  return LinearGradient(
                    colors: [Colors.amber, Colors.purple ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight
                  ).createShader(bounds);
                },
                child: Icon(MdiIcons.google, color: Colors.white, size: 70
                ),
                ),
                //boton
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
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
