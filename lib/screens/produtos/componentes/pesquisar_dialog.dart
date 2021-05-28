import 'package:flutter/material.dart';

class PesquisarDialog extends StatelessWidget {
  final String textoInicial;

  const PesquisarDialog({this.textoInicial});

  @override
  Widget build(BuildContext context) {
    return Stack(
      //Posicionar as coisas livrimente na tela
      children: [
        Positioned(
          top: 2,
          left: 4,
          right: 4,
          child: Card(
            child: TextFormField(
              initialValue: textoInicial,
              //isso aqui muda o teclado para um botão de pesquisa
              textInputAction: TextInputAction.search,
              autofocus: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                prefixIcon: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey[700],
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              onFieldSubmitted: (valor) {
                Navigator.of(context).pop(valor);
              },
            ),
          ),
        )
      ],
    );
  }
}
