import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/helpres/validadores.dart';
import 'package:loja_virtual_completa/models/usuario_manager.dart';
import 'package:loja_virtual_completa/models/usuario.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: [
          TextButton(
            child: const Text(
              "Criar Conta",
              style: TextStyle(fontSize: 14),
            ),
            onPressed: () {
              //PARA SUBSTITUIR UMA TELA PELA OUTRA pushReplacementNamed
              Navigator.of(context).pushReplacementNamed("/criar_conta");
            },
          ),
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UsuarioManager>(
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.zero,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text("Esqueci minha senha"),
                    onPressed: () {},
                  ),
                ),
              ),
              builder: (_, usuarioManager, childQueNaoRebilda) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true, //menos altura da tela
                  children: [
                    construirCampoEmailSenha(context, usuarioManager),
                    childQueNaoRebilda, //inserido aqui só para mostrar de exemplo  de uso de parte que não atualiza
                    construirBotaoEntrar(context, usuarioManager),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Column construirCampoEmailSenha(BuildContext context, UsuarioManager usuarioManager) {
    return Column(
      children: [
        TextFormField(
          controller: emailController,
          decoration: const InputDecoration(
            hintText: "E-mail",
          ),
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          enabled: !context.read<UsuarioManager>().carregando,
          validator: (valor) {
            if (!emailValido(valor)) {
              return "Email inválido";
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: senhaController,
          decoration: const InputDecoration(
            hintText: "Senha",
          ),
          autocorrect: false,
          obscureText: true,
          enabled: !usuarioManager.carregando,
          validator: (valor) {
            if (valor.isEmpty || valor.length < 6) {
              return "Senha inválida";
            }
            return null;
          },
        ),
      ],
    );
  }

  SizedBox construirBotaoEntrar(BuildContext context, UsuarioManager usuarioManager) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          textStyle: TextStyle(
            fontSize: 16,
          ),
        ),
        child: usuarioManager.carregando
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              )
            : Text("Entrar"),
        onPressed: usuarioManager.carregando
            ? null
            : () {
                acaoBotaoEntrar(context);
              },
      ),
    );
  }

  void acaoBotaoEntrar(BuildContext context) {
    if (formKey.currentState.validate()) {
      context.read<UsuarioManager>().entrar(
            //sem o Consumer context.read<UsuarioManager>() e com Consumer usuarioManager
            usuario: Usuario(
              email: emailController.text,
              senha: senhaController.text,
            ),
            onSucces: () {
              //TODO: FECHAR TELA DE LOGIN
            },
            onFail: (erro) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(erro),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }, //nome disso é calback
          );
    }
  }
}
