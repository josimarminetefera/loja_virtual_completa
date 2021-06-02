class ItemTamanho {
  String nome;
  num preco;
  int estoque;

  ItemTamanho.mapParaItemTamanho(Map<String, dynamic> map) {
    nome = map["nome"] as String;
    preco = map["preco"] as num;
    estoque = map["estoque"] as int;
  }

  bool get temEstoque => estoque > 0;

  @override
  String toString() {
    return 'ItemTamanho{nome: $nome, preco: $preco, estoque: $estoque}';
  }
}
