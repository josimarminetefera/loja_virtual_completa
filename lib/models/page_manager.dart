import 'package:flutter/cupertino.dart';

class PageManager {
  PageManager(this._pageController);

  PageController _pageController;

  int paginaAtual = 0;

  void trocarDePagina(int paginaParaAbrir) {
    if (paginaParaAbrir == paginaAtual) return;
    paginaAtual = paginaParaAbrir;
    _pageController.jumpToPage(paginaParaAbrir);
  }
}
