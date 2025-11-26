import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proyecto_dam/pages/navbar_pages/detalle_evento_page.dart';
import 'package:proyecto_dam/services/eventos_services.dart';
import 'package:proyecto_dam/utils/app_utils.dart';
import 'package:proyecto_dam/utils/constantes.dart';

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
                    child: CircularProgressIndicator(color: Color(cSecundario)),
                  );
                }

                return ListView.separated(
                  separatorBuilder: (context, index) =>
                      Divider(color: Color(cSecundario)),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var eventos = snapshot.data!.docs[index];
                    return Slidable(
                      startActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            backgroundColor: Colors.green,
                            label: 'Ver',
                            icon: MdiIcons.viewAgenda,
                            onPressed: (context) {
                              MaterialPageRoute ruta = MaterialPageRoute(
                                builder: (context) =>
                                    DetalleEventoPage(eventoId: eventos.id.toString(),),                                          
                              );
                              print('Evento id: ' + eventos.id.toString());
                              Navigator.push(
                                context,
                                ruta,
                              ).then((value) => setState(() {}));
                            },
                          ),                          
                        ],
                      ),
                      child: ListTile(
                        leading: Icon(MdiIcons.cube),
                        title: Text(
                          eventos['titulo'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(cSecundario),
                          ),
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Fecha: ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  fechaToString(
                                    (eventos['fecha'] as Timestamp).toDate(),
                                  ),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Lugar: ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  eventos['lugar'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Categoria: ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  eventos['categoria'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Autor: ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  eventos['autor'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
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
