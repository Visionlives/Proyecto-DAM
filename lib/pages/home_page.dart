import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(color: Colors.blueAccent),
        child: Text(
          'Home Page BRO',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
