import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual_completa/models/usuario.dart';

class UsuarioManager {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> entrar(Usuario usuario) async {
    try {
      UserCredential resposta = await auth.signInWithEmailAndPassword(email: usuario.email, password: usuario.senha);
      print(resposta.user.uid);
    } catch (erro) {
      print(erro);
    }
  }
}
