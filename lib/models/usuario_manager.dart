import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual_completa/helpres/firebase_erros.dart';
import 'package:loja_virtual_completa/models/usuario.dart';

class UsuarioManager {
  final FirebaseAuth auth = FirebaseAuth.instance;

  //Esta Function é um calback que é chamado dentro da função
  Future<void> entrar({Usuario usuario, Function onFail, Function onSucces}) async {
    try {
      UserCredential resposta = await auth.signInWithEmailAndPassword(email: usuario.email, password: usuario.senha);
      onSucces();
    } catch (erro) {
      onFail(getErrorString(erro.code));
    }
  }
}
