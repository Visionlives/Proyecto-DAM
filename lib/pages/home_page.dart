import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proyecto_dam/pages/navbar_pages/agregar_evento_page.dart';
import 'package:proyecto_dam/pages/navbar_pages/listado_eventos_page.dart';
import 'package:proyecto_dam/pages/navbar_pages/listado_eventos_propios_page.dart';
import 'package:proyecto_dam/pages/navbar_pages/perfil_page.dart';
import 'package:proyecto_dam/utils/constantes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> _paginas = [
    ListadoEventosPage(),
    ListadoEventosPropiosPage(),
    AgregarEventoPage(),
    PerfilPage(),
  ];
  int _paginaSeleccionada = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gestor de Eventos USM',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(cPrimario),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
        color: Color(cPrimario),
        child: IndexedStack(children: _paginas, index: _paginaSeleccionada),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _paginaSeleccionada,
        onDestinationSelected: (indicePagina) {
          setState(() {
            _paginaSeleccionada = indicePagina;
          });
        },
        backgroundColor: Color(cCuaternario),
        labelTextStyle: WidgetStateTextStyle.resolveWith(
          (states) => TextStyle(color: Colors.white),
        ),
        destinations: [
          NavigationDestination(
            icon: Icon(MdiIcons.listBox, size: 35, color: Color(cSecundario)),
            selectedIcon: Icon(
              MdiIcons.listBoxOutline,
              size: 35,
              color: Color(cPrimario),
            ),
            label: "Listado",
          ),
          NavigationDestination(
            icon: Icon(MdiIcons.viewList, size: 35, color: Color(cSecundario)),
            selectedIcon: Icon(
              MdiIcons.viewListOutline,
              size: 35,
              color: Color(cPrimario),
            ),
            label: "Listado Propio",
          ),
          NavigationDestination(
            icon: Icon(MdiIcons.plusBox, size: 35, color: Color(cSecundario)),
            selectedIcon: Icon(
              MdiIcons.plusBoxOutline,
              size: 35,
              color: Color(cPrimario),
            ),
            label: "Agregar",
          ),
          NavigationDestination(
            icon: Icon(
              MdiIcons.accountCircle,
              size: 35,
              color: Color(cSecundario),
            ),
            selectedIcon: Icon(
              MdiIcons.accountCircleOutline,
              size: 35,
              color: Color(cPrimario),
            ),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}
