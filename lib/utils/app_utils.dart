import 'package:flutter/material.dart';

class AppUtils {
  static showSnackbar(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.purple,
      ),
    );
  }

  static Future<bool> showConfirm(
    BuildContext context,
    String titulo,
    String mensaje,
  ) async {
    final resultado = await showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          iconColor: Colors.purple,
          title: Text(titulo),
          content: Text(mensaje),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.pop(context, false),
            ),
            OutlinedButton(
              child: Text('Aceptar'),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        );
      },
    );
    return resultado ?? false;
  }
}