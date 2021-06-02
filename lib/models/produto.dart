import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual_completa/models/item_tamanho.dart';

class Produto {
  String id;
  String nome;
  String descricao;
  List<String> imagens;
  List<ItemTamanho> tamanhos;

  Produto.documentParaProduto(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    nome = documentSnapshot["nome"] as String;
    descricao = documentSnapshot["descricao"] as String;
    //lista dinamica para lista de strings
    imagens = List<String>.from(documentSnapshot.data()["imagens"] as List<dynamic>);
    tamanhos = (documentSnapshot.data()["tamanhos"] as List<dynamic> ?? []).map((tamanho) {
      return ItemTamanho.mapParaItemTamanho(tamanho as Map<String, dynamic>);
    }).toList();
    print(tamanhos);
  }
}
