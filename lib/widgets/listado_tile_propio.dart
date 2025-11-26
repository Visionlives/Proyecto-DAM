import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proyecto_dam/services/eventos_services.dart';
import 'package:proyecto_dam/utils/app_utils.dart';

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
        body: Column(
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
                        startActionPane: ActionPane(
                           motion: ScrollMotion(),
                           children: [
                            //  SlidableAction(
                            //    backgroundColor: Colors.purple,
                            //    label: 'Editar',
                            //    icon: MdiIcons.pen,
                            //    onPressed: (context) {
                            //      Navigator.push(
                            //        context,
                            //        MaterialPageRoute(
                            //          builder: (context) => ProductosEditar(
                            //            productoId: eventos.id,
                            //          ),
                            //        ),
                            //      );
                            //    },
                            //  ),
                            SlidableAction(
                               backgroundColor: Colors.red,
                               label: 'Borrar',
                               icon: MdiIcons.trashCan,
                               onPressed: (context) async {
                                
                                bool
                                aceptaBorrar = await AppUtils.showConfirm(
                                  context,
                                  'Borrar evento',
                                  '¿Desea borrar el evento ${eventos['titulo']}?',
                                );
                                if (aceptaBorrar) {
                                  await EventosServices().borrarEvento(eventos.id).then((
                                    borradoOk,
                                  ) 
                                  {                                    
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
      )
      )
    );
  }
}