import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/produto.dart';

class ProdutosItem extends StatelessWidget {
  final Produto produto;

  const ProdutosItem({this.produto});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed("/produto", arguments: produto);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Container(
            padding: EdgeInsets.all(8),
            height: 100,
            child: Row(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(produto.imagens.first),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, //ocupa o espaço vertical de 100
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        produto.nome,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          "Apartir de",
                          style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                        ),
                      ),
                      Text(
                        "R\$ 19.99",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
