import 'package:flutter/material.dart';

class CriarContaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar Conta"),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            shrinkWrap: true, //vai ocupar o menor espaço possível
            padding: EdgeInsets.all(16),
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: "Nome Compelto"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(hintText: "E-mail"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(hintText: "Senha"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(hintText: "Repita a Senha"),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    textStyle: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  child: Text("Entrar"),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
