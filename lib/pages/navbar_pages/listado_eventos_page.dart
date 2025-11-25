import 'package:flutter/material.dart';

class ListadoEventosPage extends StatefulWidget {
  const ListadoEventosPage({super.key});

  @override
  State<ListadoEventosPage> createState() => _ListadoEventosPageState();
}

class _ListadoEventosPageState extends State<ListadoEventosPage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Listado de Eventos'));
  }
}
