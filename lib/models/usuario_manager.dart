import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual_completa/helpres/firebase_erros.dart';
import 'package:loja_virtual_completa/models/usuario.dart';

class UsuarioManager extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User usuario;

  bool _carregando = false;

  bool get carregando => _carregando;

  set carregando(bool valor) {
    _carregando = valor;
    atualizarTodosObservadores();
  }

  UsuarioManager() {
    _carregarUsuarioLogado();
  }

  //Esta Function é um calback que é chamado dentro da função
  Future<void> entrar({Usuario usuario, Function onFail, Function onSucces}) async {
    try {
      carregando = true;
      UserCredential resposta = await _firebaseAuth.signInWithEmailAndPassword(email: usuario.email, password: usuario.senha);
      this.usuario = resposta.user;
      await Future.delayed(Duration(seconds: 5));
      onSucces();
    } catch (erro) {
      onFail(getErrorString(erro.code));
    }
    carregando = false;
  }

  void atualizarTodosObservadores() {
    notifyListeners();
  }

  Future<void> _carregarUsuarioLogado() async {
    final User usuarioLogado = await _firebaseAuth.currentUser;
    if (usuarioLogado != null) {
      this.usuario = usuarioLogado;
      print("Usuário Logado: " + this.usuario.uid);
    }
    atualizarTodosObservadores();
  }
}
