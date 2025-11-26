import 'package:flutter/material.dart';
import 'package:proyecto_dam/widgets/listado_tile.dart';


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
