import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_dam/services/auth_services.dart';

class EventosServices {
  AuthServices authServices = AuthServices();
  
  // Example method to fetch events
  Stream<QuerySnapshot> listarEventos() {
    return FirebaseFirestore.instance.collection('eventos').snapshots();
  }

  Stream<QuerySnapshot> listarEventosPropios() {
    String? email = authServices.getEmail().toString();
    print(email);
    return FirebaseFirestore.instance.collection('eventos').where('autor', isEqualTo: email).snapshots();
  }

  Future<void> agregarEvento(
    String autor,
    String categoria,
    DateTime fecha,
    String lugar,
    String titulo,
  ) {
    return FirebaseFirestore.instance.collection('eventos').doc().set({
      "autor": autor,
      "categoria": categoria,
      "fecha": fecha,
      "lugar": lugar,
      "titulo": titulo,
    });
  }

  // // Example method to update an existing event
  // Future<void> editarEvento(Evento evento) async {
  //   // Implementation to update an existing event in an API or database
  // }

  // // Example method to delete an event
  // Future<void> borrarEvento(String eventoId) async {
  //   // Implementation to delete an event from an API or database
  // }
}
