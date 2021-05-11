import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/helpres/validadores.dart';
import 'package:loja_virtual_completa/models/usuario.dart';
import 'package:loja_virtual_completa/models/usuario_manager.dart';
import 'package:provider/provider.dart';

class CriarContaScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  //FORMA DE NÃO USAR CONTROLLER PARA CADA UM DOS CAMPOS
  Usuario usuario = new Usuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Criar Conta"),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              shrinkWrap: true, //vai ocupar o menor espaço possível
              padding: EdgeInsets.all(16),
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: "Nome Compelto"),
                  validator: (valor) {
                    if (valor.isEmpty) {
                      return "Campo obrigatório";
                    } else if (!validarNomeCompleto(valor)) {
                      return "Informe o Nome Completo";
                    }
                    return null;
                  },
                  onSaved: (valor) => usuario.nome = valor,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(hintText: "E-mail"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (valor) {
                    if (valor.isEmpty) {
                      return "Campo obrigatório";
                    } else if (!validarEmail(valor)) {
                      return "E-mail inválido";
                    }
                    return null;
                  },
                  onSaved: (valor) => usuario.email = valor,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(hintText: "Senha"),
                  autocorrect: false,
                  obscureText: true,
                  validator: (valor) {
                    if (valor.isEmpty) {
                      return "Campo obrigatório";
                    } else if (!validarSenha(valor)) {
                      return "Senha muito curta";
                    }
                    return null;
                  },
                  onSaved: (valor) => usuario.senha = valor,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(hintText: "Repita a Senha"),
                  autocorrect: false,
                  obscureText: true,
                  validator: (valor) {
                    if (valor.isEmpty) {
                      return "Campo obrigatório";
                    } else if (!validarSenha(valor)) {
                      return "Senha muito curta";
                    }
                    return null;
                  },
                  onSaved: (valor) => usuario.senhaConfirmar = valor,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      textStyle: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    child: Text("Criar Conta"),
                    onPressed: () => acaoBotaoCriarConta(context),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void acaoBotaoCriarConta(BuildContext context) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save(); //isso chama o onSaved de todos campos
      if (usuario.senha != usuario.senhaConfirmar) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("As senhas informadas estão diferentes!"),
            backgroundColor: Colors.redAccent,
          ),
        );
        return;
      }

      context.read<UsuarioManager>().criarConta(
            usuario: usuario,
            onSucces: () {
              //TODO POP
              debugPrint("Suceso");
            },
            onFail: (erro) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(erro),
                  backgroundColor: Colors.redAccent,
                ),
              );
            },
          );
    }
  }
}
