import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/page_manager.dart';
import 'package:provider/provider.dart';

class CustomDrawerItem extends StatelessWidget {
  const CustomDrawerItem({@required this.iconData, @required this.titulo, @required this.paginaParaAbrir});

  final IconData iconData;
  final String titulo;
  final int paginaParaAbrir;

  @override
  Widget build(BuildContext context) {
    final int paginaAtual = context.watch<PageManager>().paginaAtual;

    return InkWell(
      onTap: () {
        context.read<PageManager>().trocarDePagina(paginaParaAbrir);
        debugPrint("Cliquei na página $paginaParaAbrir");
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData,
                size: 32,
                color: (paginaAtual == paginaParaAbrir) ? Theme.of(context).primaryColor : Colors.grey[700],
              ),
            ),
            Text(
              titulo,
              style: TextStyle(
                fontSize: 16,
                color: (paginaAtual == paginaParaAbrir) ? Theme.of(context).primaryColor : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
