import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/produto.dart';

class ProdutoManager extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestoreInstance = FirebaseFirestore.instance;
  List<Produto> todosProdutos = [];

  ProdutoManager() {
    _carregarTodosProdutos();
  }

  String _palavraBuscada = "";

  String get palavraBuscada => _palavraBuscada;

  set palavraBuscada(String novoValor) {
    _palavraBuscada = novoValor;
    atualizarTodosObservadores();
  }

  List<Produto> get listaDeProdutosFiltrada {
    List<Produto> listaDeProdutosFiltrada = [];
    if (_palavraBuscada.isEmpty) {
      listaDeProdutosFiltrada.addAll(todosProdutos);
    } else {
      listaDeProdutosFiltrada.addAll(todosProdutos.where((produto) => produto.nome.toLowerCase().contains(_palavraBuscada.toLowerCase())));
    }
    return listaDeProdutosFiltrada;
  }

  Future<void> _carregarTodosProdutos() async {
    //TODOS DOCUMENTOS DE PRODUTOS
    final QuerySnapshot querySnapshot = await _firebaseFirestoreInstance.collection("produtos").get();

    //cada item da lista em produto para depois jogar em uma lista de produtos
    todosProdutos = querySnapshot.docs.map((documentSnapshot) => Produto.documentParaProduto(documentSnapshot)).toList();
  }

  void atualizarTodosObservadores() {
    notifyListeners();
  }
}
