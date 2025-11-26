import 'package:flutter/material.dart';
import 'package:proyecto_dam/widgets/listado_tile_propio.dart';

class ListadoEventosPropiosPage extends StatefulWidget {
  const ListadoEventosPropiosPage({super.key});

  @override
  State<ListadoEventosPropiosPage> createState() => _ListadoEventosPropiosPageState();
}

class _ListadoEventosPropiosPageState extends State<ListadoEventosPropiosPage> {
  @override
  Widget build(BuildContext context) {
    return ListadoTilePropio();
  }
}