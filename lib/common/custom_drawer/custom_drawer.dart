import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/common/custom_drawer/custom_drawer_cabecalho.dart';
import 'package:loja_virtual_completa/common/custom_drawer/custom_drawer_item.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          CustomDrawerCabecalho(),
          CustomDrawerItem(iconData: Icons.home, titulo: "Início", paginaParaAbrir: 0),
          CustomDrawerItem(iconData: Icons.list, titulo: "Produtos", paginaParaAbrir: 1),
          CustomDrawerItem(iconData: Icons.playlist_add_check, titulo: "Meus Pedidos", paginaParaAbrir: 2),
          CustomDrawerItem(iconData: Icons.location_on, titulo: "Lojas", paginaParaAbrir: 3),
        ],
      ),
    );
  }
}
