import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/produto.dart';
import 'package:loja_virtual_completa/models/produto_manager.dart';
import 'package:loja_virtual_completa/models/usuario_manager.dart';
import 'package:loja_virtual_completa/screens/base/base_screen.dart';
import 'package:loja_virtual_completa/screens/criar_conta/criar_conta_screen.dart';
import 'package:loja_virtual_completa/screens/login/login_screen.dart';
import 'package:loja_virtual_completa/screens/produto/produto_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  _testesComFirebase();
}

void _testesComFirebase() async {
  //criando um novo documento
  FirebaseFirestore.instance.collection('compilacao').add({'data': DateTime.now()});
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
    return MultiProvider(
      providers: [
        //false = porque ele já instancie o UsuarioManager ASSIM FICA INSTANTÂNEO
        //lazy: false, // se ficar true só vai carregar isso aqui quando for ler algum lugar que usa o UsuarioManager
        ChangeNotifierProvider(create: (_) => UsuarioManager(), lazy: false),
        ChangeNotifierProvider(create: (_) => ProdutoManager(), lazy: false),
      ],
      child: MaterialApp(
        title: 'Loja Josimar',
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 4, 125, 141),
          scaffoldBackgroundColor: Color.fromARGB(255, 4, 125, 141),
          appBarTheme: const AppBarTheme(
            elevation: 0,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings) {
          // settings contem todos os arguments
          switch (settings.name) {
            case "/login":
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case "/criar_conta":
              return MaterialPageRoute(builder: (_) => CriarContaScreen());
            case "/produto":
              return MaterialPageRoute(
                builder: (_) => ProdutoScreen(
                  produto: settings.arguments as Produto,
                ),
              );
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
