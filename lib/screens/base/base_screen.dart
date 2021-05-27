import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual_completa/models/pagina_manager.dart';
import 'package:loja_virtual_completa/screens/login/login_screen.dart';
import 'package:loja_virtual_completa/screens/produtos/produtos_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PaginaManager(pageController),
      child: PageView(
        //physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text("Home"),
            ),
          ),
          ProdutosScreen(),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text("2"),
            ),
          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text("3"),
            ),
          ),
        ],
      ),
    );
  }
}
