import 'package:flutter/cupertino.dart';

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
