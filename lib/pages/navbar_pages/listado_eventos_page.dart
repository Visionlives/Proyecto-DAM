import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proyecto_dam/pages/Widget/listado_tile.dart';
import 'package:proyecto_dam/services/eventos_services.dart';

class ListadoEventosPage extends StatefulWidget {
  const ListadoEventosPage({super.key});

  @override
  State<ListadoEventosPage> createState() => _ListadoEventosPageState();
}

class _ListadoEventosPageState extends State<ListadoEventosPage> {
  
  
  @override  
  Widget build(BuildContext context) {
    return ListadoTile();
  }
}
