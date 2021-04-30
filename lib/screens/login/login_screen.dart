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
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "E-mail",
                      ),
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
                    childQueNaoRebilda,
                    construirBotaoEntrar(context, usuarioManager)
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  SizedBox construirBotaoEntrar(BuildContext context, UsuarioManager usuarioManager) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        child: usuarioManager.carregando
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              )
            : Text("Entrar"),
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          textStyle: TextStyle(
            fontSize: 18,
          ),
        ),
        onPressed: usuarioManager.carregando
            ? null
            : () {
                if (formKey.currentState.validate()) {
                  context.read<UsuarioManager>().entrar(
                        //sem o Consumer context.read<UsuarioManager>() e com Consumer usuarioManager
                        usuario: Usuario(
                          email: emailController.text,
                          senha: senhaController.text,
                        ),
                        onFail: (erro) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(erro),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        }, //nome disso é calback
                        onSucces: () {
                          //TODO: FECHAR TELA DE LOGIN
                        },
                      );
                }
              },
      ),
    );
  }
}
