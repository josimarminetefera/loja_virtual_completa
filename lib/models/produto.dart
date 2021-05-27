import 'package:cloud_firestore/cloud_firestore.dart';

class Produto {
  String id;
  String nome;
  String descricao;
  List<String> imagens;

  Produto.documentParaProduto(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    nome = documentSnapshot["nome"] as String;
    descricao = documentSnapshot["descricao"] as String;
    //lista dinamica para lista de strings
    imagens = List<String>.from(documentSnapshot.data()["imagens"] as List<dynamic>);
  }
}
