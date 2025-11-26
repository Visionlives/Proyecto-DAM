import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proyecto_dam/services/eventos_services.dart';

class ListadoTile extends StatefulWidget {
  const ListadoTile({super.key});

  @override
  State<ListadoTile> createState() => _ListadoTileState();
}

class _ListadoTileState extends State<ListadoTile> {
  String fechaToString(DateTime fecha) {
    return '${fecha.day}/${fecha.month}/${fecha.year} ${fecha.hour}:${fecha.minute}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: StreamBuilder(
                stream: EventosServices().listarEventos(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    );
                  }

                  return ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var eventos = snapshot.data!.docs[index];
                      return Slidable(                        
                        child: ListTile(
                          leading: Icon(MdiIcons.cube),
                          title: Text(eventos['titulo']),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  Text('Fecha: '),
                                  Text(fechaToString((eventos['fecha'] as Timestamp).toDate(),),)
                                  ],
                              ),
                              Row(
                                children: [
                                  Text('Lugar: '),
                                  Text(
                                    eventos['lugar'],                                
                                  ),                                  
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Categoria: '),
                                  Text(eventos['categoria']),
                                ],
                              ),
                              Row(children: [
                                Text('Autor: '),
                                Text(eventos['autor']),
                              ],)
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      );
  }
}