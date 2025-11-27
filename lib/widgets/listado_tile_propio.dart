import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proyecto_dam/pages/navbar_pages/detalle_evento_page.dart';
import 'package:proyecto_dam/services/eventos_services.dart';
import 'package:proyecto_dam/utils/app_utils.dart';
import 'package:proyecto_dam/utils/constantes.dart';

class ListadoTilePropio extends StatefulWidget {
  const ListadoTilePropio({super.key});

  @override
  State<ListadoTilePropio> createState() => _ListadoTilePropioState();
}

class _ListadoTilePropioState extends State<ListadoTilePropio> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String fechaToString(DateTime fecha) {
    return '${fecha.day}/${fecha.month}/${fecha.year} ${fecha.hour}:${fecha.minute}';
  }

  Future<void> refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => refresh(),
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          color: Color(cPrimario),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: StreamBuilder(
                    stream: EventosServices().listarEventosPropios(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData ||
                          snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(color: Color(cSecundario)),
                        );
                      }

                      return ListView.separated(
                        separatorBuilder: (context, index) =>
                            Divider(color: Colors.white),
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
                                      builder: (context) => DetalleEventoPage(
                                        eventoId: eventos.id.toString(),
                                      ),
                                    );
                                    print('Evento id: ' + eventos.id.toString());
                                    Navigator.push(
                                      context,
                                      ruta,
                                    ).then((value) => setState(() {}));
                                  },
                                ),
                                SlidableAction(
                                  backgroundColor: Colors.red,
                                  label: 'Borrar',
                                  icon: MdiIcons.trashCan,
                                  onPressed: (context) async {
                                    bool aceptaBorrar = await AppUtils.showConfirm(
                                      context,
                                      'Borrar evento',
                                      '¿Desea borrar el evento ${eventos['titulo']}?',
                                    );
                                    if (aceptaBorrar) {
                                      await EventosServices()
                                          .borrarEvento(eventos.id)
                                          .then((borradoOk) {
                                            AppUtils.showSnackbar(
                                              _scaffoldKey.currentContext!,
                                              'Evento borrado correctamente',
                                            );
                                            setState(() {});
                                          });
                                    }
                                  },
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: eventos['categoria'] == "Charla"
                                  ? Icon(
                                      MdiIcons.accountVoice,
                                      size: 40,
                                      color: Color(cTerciario),
                                    )
                                  : eventos['categoria'] == "Coloquio"
                                  ? Icon(
                                      MdiIcons.forumOutline,
                                      size: 40,
                                      color: Color(cTerciario),
                                    )
                                  : eventos['categoria'] == "Workshop"
                                  ? Icon(
                                      MdiIcons.hammerWrench,
                                      size: 40,
                                      color: Color(cTerciario),
                                    )
                                  : Icon(
                                      MdiIcons.chatQuestion,
                                      size: 40,
                                      color: Color(cTerciario),
                                    ),
                              title: Text(
                                eventos['titulo'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(cTerciario),
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
          ),
        ),
      ),
    );
  }
}
