import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_dam/services/auth_services.dart';
import 'package:proyecto_dam/services/categorias_services.dart';
import 'package:proyecto_dam/services/eventos_services.dart';
import 'package:proyecto_dam/utils/app_utils.dart';
import 'package:proyecto_dam/utils/constantes.dart';

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
  String errorCategoria = "";
  TextEditingController autorCtrl = TextEditingController();

  final llaveFormulario = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //Formulario de agregar evento
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Color(cTerciario)],
                ),
              ),
              child: Form(
                key: llaveFormulario,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                        'Agregar Evento',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    //titulo del evento
                    TextFormField(
                      controller: tituloCtrl,
                      decoration: InputDecoration(labelText: 'Título'),
                      validator: (titulo) {
                        if (titulo == null || titulo.isEmpty) {
                          return 'Ingrese el título';
                        }
                        if (titulo.length < 5) {
                          return 'El título debe tener al menos 5 caracteres';
                        }
                        return null;
                      },
                    ),
                    //Categoria del evento
                    FutureBuilder(
                      future: categoriasServices.listarCategorias(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData ||
                            snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(color: Color(cSecundario)),
                          );
                        }
                        var categorias = snapshot.data!.docs;
                        return DropdownButtonFormField<String>(
                          decoration: InputDecoration(labelText: 'Categoría'),
                          items: categorias.map<DropdownMenuItem<String>>((categoria) {
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
                    // Mensaje de error si no se selecciona categoría
                    if (errorCategoria.isNotEmpty)
                      Text(
                        "Selecciona una categoria",
                        style: TextStyle(color: Colors.red),
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
                      decoration: InputDecoration(labelText: 'Hora de inicio (0-23)'),
                      validator: (horas) {
                        if (horas == null || horas.isEmpty) {
                          return 'Ingrese las horas';
                        }
                        int? horasInt = int.tryParse(horas);
                        if (horasInt == null || horasInt < 0 || horasInt > 23) {
                          return 'La hora debe estar entre 0 y 23';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: minutoCtrl,
                      decoration: InputDecoration(labelText: 'Minuto de inicio (0-59)'),
                      validator: (minutos) {
                        if (minutos == null || minutos.isEmpty) {
                          return 'Ingrese los minutos';
                        }
                        int? minutosInt = int.tryParse(minutos);
                        if (minutosInt == null || minutosInt < 0 || minutosInt > 59) {
                          return 'Los minutos deben estar entre 0 y 59';
                        }
                        return null;
                      },
                    ),
                    //lugar del evento
                    TextFormField(
                      controller: lugarCtrl,
                      decoration: InputDecoration(labelText: 'Lugar'),
                      validator: (lugar) {
                        if (lugar == null || lugar.isEmpty) {
                          return 'El lugar es obligatorio';
                        }
                        if (lugar.length < 1) {
                          return 'El lugar debe tener al menos 1 caracteres';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Botones fijos en la parte inferior
        Column(
          children: [
            //Botón Agregar
            Container(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Color(cCuaternario),
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  'Agregar Evento',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                onPressed: () async {
                  if (llaveFormulario.currentState!.validate() &&
                      categoriaSeleccionada.isNotEmpty) {
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
                    setState(() {
                      errorCategoria = "";
                      categoriaSeleccionada = "";
                      tituloCtrl.clear();
                      horaCtrl.clear();
                      minutoCtrl.clear();
                      lugarCtrl.clear();
                    });
                    AppUtils.showSnackbar(context, 'Evento agregado correctamente');
                  } else {
                    setState(() {
                      errorCategoria = "Selecciona una categoria";
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
