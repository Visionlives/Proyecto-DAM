import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proyecto_dam/services/auth_services.dart';
import 'package:proyecto_dam/services/categorias_services.dart';
import 'package:proyecto_dam/services/eventos_services.dart';

class AgregarEventoPage extends StatefulWidget {
  const AgregarEventoPage({super.key});

  @override
  State<AgregarEventoPage> createState() => _AgregarEventoPageState();
}

class _AgregarEventoPageState extends State<AgregarEventoPage> {
  AuthServices authServices = AuthServices();
  CategoriasServices categoriasServices = CategoriasServices();
  EventosServices eventosServices = EventosServices();

  TextEditingController tituloCtrl = TextEditingController();
  DateTime fecha = DateTime.now();
  TextEditingController horaCtrl = TextEditingController();
  TextEditingController minutoCtrl = TextEditingController();
  
  TextEditingController lugarCtrl = TextEditingController();
  String categoriaSeleccionada = "";
  TextEditingController autorCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Formulario de agregar evento
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      'Agregar Evento',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //titulo del evento
                  TextFormField(
                    controller: tituloCtrl,
                    decoration: InputDecoration(labelText: 'Título'),
                  ),                  
                  //Categorias de eventos
                  FutureBuilder(
                    future: categoriasServices.listarCategorias(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData ||
                          snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(color: Colors.blue),
                        );
                      }
                      var categorias = snapshot.data!.docs;
                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(labelText: 'Categoría'),
                        items: categorias.map<DropdownMenuItem<String>>((
                          categoria,
                        ) {
                          return DropdownMenuItem<String>(
                            child: Text(categoria['nombre']),
                            value: categoria['nombre'],
                          );
                        }).toList(),
                        onChanged: (categoria) {
                          categoriaSeleccionada = categoria!;
                        },
                      );
                    },
                  ),
                  //fecha del evento
                  DatepickerFecha(
                    onDateChanged: (fechaSeleccionada) {
                      fecha = fechaSeleccionada;
                    },
                  ),
                  //hora y minuto del evento
                  TextFormField(
                    controller: horaCtrl,
                    decoration: InputDecoration(labelText: 'Horas'),
                  ),
                  TextFormField(
                    controller: minutoCtrl,
                    decoration: InputDecoration(labelText: 'Minutos'),
                  ),
                  //lugar del evento
                  TextFormField(
                    controller: lugarCtrl,
                    decoration: InputDecoration(labelText: 'Lugar'),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Botones fijos en la parte inferior
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              //Botón Agregar
              Container(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('AGREGAR EVENTO'),
                  onPressed: () async {
                    setState(() {
                          fecha = DateTime(
                            fecha.year,
                            fecha.month,
                            fecha.day,
                            int.parse(horaCtrl.text.trim()),
                            int.parse(minutoCtrl.text.trim()),
                          );
                        });
                    await eventosServices.agregarEvento(
                      authServices.getCurrentUser()!.email.toString(),
                      categoriaSeleccionada,
                      fecha,
                      lugarCtrl.text.trim(),
                      tituloCtrl.text.trim(),
                    );
                  },
                ),
              ),              
            ],
          ),
        ),
      ],
    );
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
          Text('Fecha del evento:'),
          Text(
            formatearFecha(fechaSeleccionada.toString()),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          IconButton(
            icon: Icon(MdiIcons.calendar, color: Colors.red),
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: fechaSeleccionada,
                firstDate: DateTime(1950),
                lastDate: DateTime(2050),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        surface: Colors.white,
                        onSurface: Colors.black,
                      ),
                      dialogTheme: DialogThemeData(
                        backgroundColor: Colors.white,
                      ),
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
        ],
      ),
    );
  }
}