import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/helpres/firebase_erros.dart';
import 'package:loja_virtual_completa/models/usuario.dart';

class UsuarioManager extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool carregando = false;

  //Esta Function é um calback que é chamado dentro da função
  Future<void> entrar({Usuario usuario, Function onFail, Function onSucces}) async {
    try {
      alterarCarregando(true);
      UserCredential resposta = await auth.signInWithEmailAndPassword(email: usuario.email, password: usuario.senha);

      await Future.delayed(Duration(seconds: 5));

      onSucces();
    } catch (erro) {
      onFail(getErrorString(erro.code));
    }

    alterarCarregando(false);
  }

  void alterarCarregando(bool valor) {
    carregando = valor;
    atualizarTodosObservadores();
  }

  void atualizarTodosObservadores() {
    notifyListeners();
  }
}
