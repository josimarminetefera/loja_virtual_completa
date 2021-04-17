import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/screens/base/base_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  _testesComFirebase();
}

void _testesComFirebase() async {
  //criando um novo documento
  FirebaseFirestore.instance.collection('compilacao').add({'nome': 'nome campo'});
  /*FirebaseFirestore.instance.collection('compilacao').doc('BBL9FFPRNnlGFM1uflqm').set({'nome': 'nome campo'});
  FirebaseFirestore.instance.collection('compilacao').doc('BBL9FFPRNnlGFM1uflqm').update({'nome': 'nome campo'});
  DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('compilacao').doc('BBL9FFPRNnlGFM1uflqm').get();
  print(documentSnapshot.data()["nome"]);
  //atualizou o documento ele tem que mudar aqui
  FirebaseFirestore.instance.collection('compilacao').doc('BBL9FFPRNnlGFM1uflqm').snapshots().listen((event) {
    print(event.data());
  });
  //todos documentos
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('compilacao').get();
  //print(querySnapshot.docs);
  for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
    print(documentSnapshot.data());
  }*/
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loja Josimar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BaseScreen(),
    );
  }
}
