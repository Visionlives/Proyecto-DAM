import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriasServices {
  Future<QuerySnapshot> listarCategorias() {
    return FirebaseFirestore.instance
        .collection('categorias')
        .orderBy('nombre')
        .get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> buscarCharlaPorNombre(String nombre) async {
    final q = await FirebaseFirestore.instance
        .collection('categorias')
        .where('nombre', isEqualTo: nombre)
        .limit(1)
        .get();
    if (q.docs.isEmpty) return null;
    return q.docs.first;
  }
}
