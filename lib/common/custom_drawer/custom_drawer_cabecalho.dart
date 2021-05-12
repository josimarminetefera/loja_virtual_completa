import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/usuario_manager.dart';
import 'package:provider/provider.dart';

class CustomDrawerCabecalho extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 180,
      child: Consumer<UsuarioManager>(
        builder: (context, usuarioManager, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround, //espaçar os textos dentro da coluna para ocupar td o espaço
            children: [
              Text(
                "Loja do \nJosimar",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Olá, ${usuarioManager.usuarioAtual?.nome ?? ''}",
                overflow: TextOverflow.ellipsis, //para nomes grandes ele não quebrar o layout
                maxLines: 2,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                child: Text(
                  usuarioManager.usuarioEstaLogado ? "Sair" : "Entre ou Cadastre-se >",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  if (usuarioManager.usuarioEstaLogado) {
                    usuarioManager.sair();
                  } else {
                    Navigator.of(context).pushNamed("/login");
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
