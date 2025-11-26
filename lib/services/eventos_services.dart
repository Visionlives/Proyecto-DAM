import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_dam/services/auth_services.dart';

class EventosServices {
  AuthServices authServices = AuthServices();
  
  // Example method to fetch events
  Stream<QuerySnapshot> listarEventos() {
    return FirebaseFirestore.instance.collection('eventos').snapshots();
  }

  Stream<QuerySnapshot> listarEventosPropios() {
    return FirebaseFirestore.instance.collection('eventos').where('autor', isEqualTo: authServices.getCurrentUser()?.email.toString()).snapshots();
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


  Future<void> borrarEvento(String eventoId) async {
    return FirebaseFirestore.instance.collection('eventos').doc(eventoId).delete();
  }
}
