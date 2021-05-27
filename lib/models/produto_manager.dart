import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/produto.dart';

class ProdutoManager extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestoreInstance = FirebaseFirestore.instance;
  List<Produto> _todosProdutos = [];

  ProdutoManager() {
    _carregarTodosProdutos();
  }

  Future<void> _carregarTodosProdutos() async {
    //TODOS DOCUMENTOS DE PRODUTOS
    final QuerySnapshot querySnapshot = await _firebaseFirestoreInstance.collection("produtos").get();

    //cada item da lista em produto para depois jogar em uma lista de produtos
    _todosProdutos = querySnapshot.docs.map((documentSnapshot) => Produto.documentParaProduto(documentSnapshot)).toList();
  }

  void atualizarTodosObservadores() {
    notifyListeners();
  }
}
