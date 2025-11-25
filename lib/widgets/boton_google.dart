import 'package:flutter/material.dart';

class BotonGoogle extends StatelessWidget {
  const BotonGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      width: double.infinity,
      child: Text("Iniciar con Google"),
    );
  }
}
