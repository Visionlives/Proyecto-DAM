import 'package:cloud_firestore/cloud_firestore.dart';

class EventosServices {
  // Example method to fetch events
  Stream<QuerySnapshot> listarEventos() {
    return FirebaseFirestore.instance.collection('eventos').snapshots();
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
