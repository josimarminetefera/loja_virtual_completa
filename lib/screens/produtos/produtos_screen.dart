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
        title: Consumer<ProdutoManager>(
          builder: (context, produtoManager, child) {
            if (produtoManager.palavraBuscada.isEmpty) {
              return Text("Produtos");
            } else {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return GestureDetector(
                    onTap: () => _ativarPesquisarDialog(context, produtoManager),
                    child: Container(
                      width: constraints.biggest.width,
                      child: Text(
                        produtoManager.palavraBuscada,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
        centerTitle: true,
        actions: [
          Consumer<ProdutoManager>(
            builder: (context, produtoManager, child) {
              if (produtoManager.palavraBuscada.isEmpty) {
                return IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _ativarPesquisarDialog(context, produtoManager),
                );
              } else {
                return IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () async {
                    //context.read<ProdutoManager>().palavraBuscada = "";
                    produtoManager.palavraBuscada = "";
                  },
                );
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

  void _ativarPesquisarDialog(BuildContext context, ProdutoManager produtoManager) async {
    final palavraBuscada = await showDialog<String>(
      context: context,
      builder: (_) => PesquisarDialog(
        textoInicial: produtoManager.palavraBuscada,
      ),
    );
    if (palavraBuscada != null) {
      produtoManager.palavraBuscada = palavraBuscada;
    }
  }
}
