import 'package:flutter/material.dart';
import 'package:proyecto_dam/services/auth_services.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Container(      
      child: Column(
        children: [
          Row(            
            children: [
              Icon(Icons.person, size: 50),
              Text('Tu Perfil'),
            ],
          ),
          Text('Nombre: ${authServices.getCurrentUser()?.displayName.toString()}'),          
          Text('Correo: ${authServices.getCurrentUser()?.email.toString()}'),
          Text('Numero de Teléfono: ${authServices.getCurrentUser()?.phoneNumber.toString()}'),
          Spacer(),
          Container(
                width: double.infinity,
                child: FilledButton(
                  child: Text('Cerrar Sesión'),
                  onPressed: () async {
                    try {
                      authServices.logout();
                    } catch (ex) {
                      print("ERROR EN BOTON LOGOUT: $ex");
                    }
                  },
                ),
              ),
        ],
      ),
    );
  }
}