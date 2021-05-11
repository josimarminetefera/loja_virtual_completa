import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Usuario {
  String id;
  String nome;
  String email;
  String senha;
  String senhaConfirmar;

  Usuario({this.id, this.nome, this.email, this.senha, this.senhaConfirmar});

  DocumentReference get firestoreReference => FirebaseFirestore.instance.doc("usuario/$id");

  Future<void> salvarDados() async {
    //await FirebaseFirestore.instance.collection("usuario").doc(id).set(paraMap());
    await firestoreReference.set(paraMap());
  }

  Map<String, dynamic> paraMap() {
    return {
      'nome': nome,
      'email': email,
    };
  }
}
