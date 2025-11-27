import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proyecto_dam/utils/constantes.dart';

class AppUtils {
  static showSnackbar(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          mensaje,
          style: TextStyle(
            fontSize: 18,
            color: Color(cPrimario),
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Color(cSecundario),
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
          backgroundColor: Color(cPrimario),
          iconColor: Color(cSecundario),
          title: Text(titulo, style: TextStyle(fontSize: 18, color: Colors.white)),
          content: Text(mensaje, style: TextStyle(fontSize: 18, color: Colors.white)),
          actions: [
            TextButton(
              child: Text('Cancelar', style: TextStyle(color: Colors.white)),
              onPressed: () => Navigator.pop(context, false),
            ),
            OutlinedButton(
              child: Text('Aceptar', style: TextStyle(color: Colors.white)),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        );
      },
    );
    return resultado ?? false;
  }
}

class DatepickerFecha extends StatefulWidget {
  final Function(DateTime) onDateChanged;

  const DatepickerFecha({super.key, required this.onDateChanged});

  @override
  State<DatepickerFecha> createState() => _DatepickerFechaState();
}

class _DatepickerFechaState extends State<DatepickerFecha> {
  DateTime fechaSeleccionada = DateTime.now();

  String formatearFecha(String fecha) {
    DateTime fechaDateTime = DateTime.parse(fecha);
    return DateFormat('dd/MM/yyyy').format(fechaDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Text('Apriete para seleccionar fecha: ', style: TextStyle(fontSize: 14)),
          Column(
            children: [
              IconButton(
                icon: Icon(MdiIcons.calendarAccount, color: Color(cPrimario), size: 50),
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: fechaSeleccionada,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2050),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Color(cSecundario),
                            onPrimary: Color(cPrimario),
                            surface: Color(cPrimario),
                            onSurface: Colors.white,
                          ),
                          dialogTheme: DialogThemeData(backgroundColor: Colors.white),
                        ),
                        child: child!,
                      );
                    },
                  ).then((fecha) {
                    if (fecha != null) {
                      setState(() {
                        fechaSeleccionada = fecha;
                      });
                      widget.onDateChanged(fecha);
                    }
                  });
                },
              ),
              Text(
                formatearFecha(fechaSeleccionada.toString()),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
