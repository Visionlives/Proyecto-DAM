import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriasServices {
  Future<QuerySnapshot> listarCategorias() {
    return FirebaseFirestore.instance
        .collection('categorias')
        .orderBy('nombre')
        .get();
  }
}
