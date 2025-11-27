import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_dam/services/categorias_services.dart';
import 'package:proyecto_dam/services/eventos_services.dart';
import 'package:proyecto_dam/utils/constantes.dart';

class DetalleEventoPage extends StatelessWidget {
  const DetalleEventoPage({super.key, required this.eventoId});

  final String eventoId;

  String fechaToString(DateTime fecha) {
    return '${fecha.day}/${fecha.month}/${fecha.year} ${fecha.hour}:${fecha.minute}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(cSecundario),
        title: Text(
          'Detalle del Evento',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
      ),
      body: Container(
        color: Color(cPrimario),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: FutureBuilder(
            future: EventosServices().listarEventoSolo(eventoId),
            builder:
                (
                  context,
                  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot,
                ) {
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(color: Colors.amber));
                  }

                  var eventos = snapshot.data!;

                  return Container(
                    child: Column(
                      children: [
                        Container(margin: EdgeInsets.only(top: 10, bottom: 20)),
                        Text(
                          eventos['titulo'],
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(cSecundario),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(margin: EdgeInsets.only(top: 20)),
                        Row(
                          children: [
                            Text(
                              'Autor: ',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Text(
                              eventos['autor'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Container(margin: EdgeInsets.only(top: 20)),
                        Row(
                          children: [
                            Text(
                              'Lugar: ',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Text(
                              eventos['lugar'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Container(margin: EdgeInsets.only(top: 20)),
                        Row(
                          children: [
                            Text(
                              'Categoria: ',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Text(
                              eventos['categoria'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Container(margin: EdgeInsets.only(top: 20)),
                        Row(
                          children: [
                            Text(
                              'Fecha: ',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Text(
                              fechaToString((eventos['fecha'] as Timestamp).toDate()),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Container(margin: EdgeInsets.only(top: 40)),
                        Spacer(),
                        FutureBuilder(
                          future: CategoriasServices().buscarCharlaPorNombre(
                            eventos['categoria'],
                          ),
                          builder:
                              (
                                context,
                                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>?>
                                snapshot,
                              ) {
                                if (!snapshot.hasData ||
                                    snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Color(cSecundario),
                                    ),
                                  );
                                }
                                var categoriaData = snapshot.data!;
                                return Image(
                                  image: AssetImage(categoriaData['ruta']),
                                  height: 200,
                                );
                              },
                        ),
                        Container(padding: EdgeInsets.only(bottom: 40)),
                        SizedBox(height: 80),
                        Container(
                          padding: EdgeInsets.only(bottom: 40),
                          width: double.infinity,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Color(cCuaternario),
                              foregroundColor: Colors.white,
                            ),
                            child: Text(
                              'Volver',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                  );
                },
          ),
        ),
      ),
    );
  }
}
