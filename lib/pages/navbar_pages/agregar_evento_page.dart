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
                  //autor del evento
                  TextFormField(
                    controller: autorCtrl,
                    decoration: InputDecoration(labelText: 'Autor'),
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
                    decoration: InputDecoration(labelText: 'Hora (HH:MM)'),
                    keyboardType: TextInputType.datetime,
                    onChanged: (value) {
                      List<String> partes = value.split(':');
                      if (partes.length == 2) {
                        int hora = int.parse(partes[0]);
                        int minuto = int.parse(partes[1]);
                        setState(() {
                          fecha = DateTime(
                            fecha.year,
                            fecha.month,
                            fecha.day,
                            hora,
                            minuto,
                          );
                        });
                      }
                    },
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
                    await eventosServices.agregarEvento(
                      autorCtrl.text.trim(),
                      categoriaSeleccionada,
                      fecha,
                      lugarCtrl.text.trim(),
                      tituloCtrl.text.trim(),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              //Botón Cerrar Sesión
              Container(
                width: double.infinity,
                child: FilledButton(
                  child: Text('Cerrar Sesión'),
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

// Column(
//       children: [
//         Expanded(
//           child: SingleChildScrollView(
//             padding: EdgeInsets.all(10),
//             child: Form(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     child: Text(
//                       'Agregar Piloto',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   //nombre del piloto
//                   TextFormField(
//                     controller: nombreCtrl,
//                     decoration: InputDecoration(labelText: 'Nombre'),
//                   ),
//                   //apellido del piloto
//                   TextFormField(
//                     controller: apellidoCtrl,
//                     decoration: InputDecoration(labelText: 'Apellido'),
//                   ),
//                   //Categorias de eventos
//                   FutureBuilder(
//                     future: categoriasServices.listarCategorias(),
//                     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                       if (!snapshot.hasData ||
//                           snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(
//                           child: CircularProgressIndicator(color: Colors.blue),
//                         );
//                       }
//                       var categorias = snapshot.data!.docs;
//                       return DropdownButtonFormField<String>(
//                         decoration: InputDecoration(labelText: 'Categoria'),
//                         items: categorias.map<DropdownMenuItem<String>>((
//                           categoria,
//                         ) {
//                           return DropdownMenuItem<String>(
//                             child: Text(categoria['nombre']),
//                             value: categoria['nombre'],
//                           );
//                         }).toList(),
//                         onChanged: (categoria) {
//                           categoriaSeleccionada = categoria!;
//                         },
//                       );
//                     },
//                   ),
//                   //fecha de nacimiento
//                   DatepickerFechaNacimiento(
//                     onDateChanged: (fecha) {
//                       fechaNacimiento = fecha;
//                     },
//                   ),
//                   //Cantidad de victorias
//                   TextFormField(
//                     controller: victoriasCtrl,
//                     decoration: InputDecoration(labelText: 'Victorias'),
//                     keyboardType: TextInputType.number,
//                   ),
//                   //Campeonatos
//                   TextFormField(
//                     controller: campeonatosCtrl,
//                     decoration: InputDecoration(labelText: 'Campeonatos'),
//                     keyboardType: TextInputType.number,
//                   ),
//                   //Número del auto
//                   TextFormField(
//                     controller: numeroAutoCtrl,
//                     decoration: InputDecoration(labelText: 'Número del Auto'),
//                     keyboardType: TextInputType.number,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         // Botones fijos en la parte inferior
//         Padding(
//           padding: EdgeInsets.all(10),
//           child: Column(
//             children: [
//               //Botón Agregar
//               Container(
//                 width: double.infinity,
//                 child: OutlinedButton(
//                   style: OutlinedButton.styleFrom(
//                     backgroundColor: Colors.amberAccent,
//                     foregroundColor: Colors.white,
//                   ),
//                   child: Text('AGREGAR PILOTO'),
//                   onPressed: () async {
//                     // print(nombreCtrl.text.trim());
//                     // print(apellidoCtrl.text.trim());
//                     // print(victoriasCtrl.text.trim());
//                     // print(campeonatosCtrl.text.trim());
//                     // print(numeroAutoCtrl.text.trim());
//                     // print(paisSeleccionado);
//                     // print(equipoSeleccionado.toString());
//                     // print(fechaNacimiento.toString());
//                     await eventosServices.agregarEvento(
//                       nombreCtrl.text.trim(),
//                       categoriaSeleccionada,
//                       fechaNacimiento,
//                       apellidoCtrl.text.trim(),
//                       numeroAutoCtrl.text.trim(),
//                     );
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//               SizedBox(height: 10),
//               //Botón Cerrar Sesión
//               Container(
//                 width: double.infinity,
//                 child: FilledButton(
//                   child: Text('Cerrar Sesión'),
//                   onPressed: () async {
//                     try {
//                       authServices.logout();
//                     } catch (ex) {
//                       print("ERROR EN BOTON LOGOUT: $ex");
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
