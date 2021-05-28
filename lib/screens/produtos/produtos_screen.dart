import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual_completa/models/produto_manager.dart';
import 'package:loja_virtual_completa/screens/produtos/componentes/produtos_item.dart';
import 'package:provider/provider.dart';

import 'componentes/pesquisar_dialog.dart';

class ProdutosScreen extends StatelessWidget {
  const ProdutosScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text("Produtos"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final palavraBuscada = await showDialog<String>(context: context, builder: (_) => PesquisarDialog());
              if (palavraBuscada != null) {
                context.read<ProdutoManager>().palavraBuscada = palavraBuscada;
              }
            },
          ),
        ],
      ),
      body: Consumer<ProdutoManager>(
        builder: (context, produtoManager, child) {
          final listaDeProdutosFiltrada = produtoManager.listaDeProdutosFiltrada;
          return ListView.builder(
            padding: const EdgeInsets.all(4),
            itemCount: listaDeProdutosFiltrada.length,
            itemBuilder: (context, index) {
              return ProdutosItem(
                produto: listaDeProdutosFiltrada[index],
              );
            },
          );
        },
      ),
    );
  }
}
