import 'package:flutter/cupertino.dart';

//PARA ALTERAR A PÁGINA QUE O APP ESTA E TAMBÉM PARA MOSTRAR PARA TODO O APP A TELA QUE ESTOU USANDO
class PaginaManager {
  PaginaManager(this._pageController);

  final PageController _pageController;

  int paginaAtual = 0;

  void trocarDePagina(int paginaParaAbrir) {
    if (paginaParaAbrir == paginaAtual) return;
    paginaAtual = paginaParaAbrir;
    _pageController.jumpToPage(paginaParaAbrir);
  }
}
