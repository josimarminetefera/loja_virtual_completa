import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual_completa/helpres/firebase_erros.dart';
import 'package:loja_virtual_completa/models/usuario.dart';

class UsuarioManager extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestoreInstance = FirebaseFirestore.instance;

  //USUÁRIO QUE ESTÁ LOGADO
  Usuario usuarioAtual;

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

      await _carregarUsuarioLogado(userioNoEntrar: resposta.user);

      await Future.delayed(Duration(seconds: 5));
      onSucces();
    } catch (erro) {
      onFail(getErrorString(erro.code));
    }
    carregando = false;
  }

  Future<void> criarConta({Usuario usuario, Function onFail, Function onSucces}) async {
    try {
      carregando = true;
      UserCredential resposta = await _firebaseAuth.createUserWithEmailAndPassword(email: usuario.email, password: usuario.senha);

      usuario.id = resposta.user.uid;
      this.usuarioAtual = usuario;

      await usuario.salvarDados();

      onSucces();
    } catch (erro) {
      onFail(getErrorString(erro.code));
    }
    carregando = false;
  }

  void atualizarTodosObservadores() {
    notifyListeners();
  }

  //pode ser o usuário logado ou ao clicar em entrar
  Future<void> _carregarUsuarioLogado({User userioNoEntrar}) async {
    final User usuarioLogado = userioNoEntrar ?? await _firebaseAuth.currentUser; //_firebaseAuth.currentUser é o usuário logado anteriormente
    if (usuarioLogado != null) {
      final DocumentSnapshot documentSnapshot = await _firebaseFirestoreInstance.collection("usuario").doc(usuarioLogado.uid).get();

      this.usuarioAtual = Usuario.documentParaUsuario(documentSnapshot);

      print("Usuário Logado: " + this.usuarioAtual.nome);
      atualizarTodosObservadores();
    }
  }
}
