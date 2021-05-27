import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual_completa/models/produto_manager.dart';
import 'package:provider/provider.dart';

class ProdutosScreen extends StatelessWidget {
  const ProdutosScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text("Produtos"),
        centerTitle: true,
      ),
      body: Consumer<ProdutoManager>(
        builder: (context, produtoManager, child) {
          return ListView.builder(
            itemCount: produtoManager.todosProdutos.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(produtoManager.todosProdutos[index].nome),
              );
            },
          );
        },
      ),
    );
  }
}
