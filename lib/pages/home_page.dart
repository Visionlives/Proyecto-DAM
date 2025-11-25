import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proyecto_dam/pages/navbar_pages/agregar_evento_page.dart';
import 'package:proyecto_dam/pages/navbar_pages/listado_eventos_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> _paginas = [ListadoEventosPage(), AgregarEventoPage()];
  int _paginaSeleccionada = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestor de Eventos'), centerTitle: true),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
        color: Colors.amberAccent,
        child: IndexedStack(children: _paginas, index: _paginaSeleccionada),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _paginaSeleccionada,
        onDestinationSelected: (indicePagina) {
          setState(() {
            _paginaSeleccionada = indicePagina;
          });
        },
        backgroundColor: Colors.purpleAccent,
        labelTextStyle: WidgetStateTextStyle.resolveWith(
          (states) => TextStyle(color: Colors.white),
        ),
        destinations: [
          NavigationDestination(
            icon: Icon(MdiIcons.homeOutline, size: 35, color: Colors.amber),
            selectedIcon: Icon(MdiIcons.home, size: 35, color: Colors.blueGrey),
            label: "Listado",
          ),
          NavigationDestination(
            icon: Icon(MdiIcons.listBoxOutline, size: 35, color: Colors.amber),
            selectedIcon: Icon(
              MdiIcons.listBox,
              size: 35,
              color: Colors.blueGrey,
            ),
            label: "Agregar",
          ),
        ],
      ),
    );
  }
}
