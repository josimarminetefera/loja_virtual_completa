import 'package:cloud_firestore/cloud_firestore.dart';

class ProdutoManager {
  final FirebaseFirestore _firebaseFirestoreInstance = FirebaseFirestore.instance;

  ProdutoManager() {
    _carregarTodosProdutos();
  }

  Future<void> _carregarTodosProdutos() async {
    //TODOS DOCUMENTOS DE PRODUTOS
    final QuerySnapshot querySnapshot = await _firebaseFirestoreInstance.collection("produtos").get();

    for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
      print(documentSnapshot.data());
    }
  }
}
