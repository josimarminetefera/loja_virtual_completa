import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/helpres/validadores.dart';
import 'package:loja_virtual_completa/models/usuario.dart';
import 'package:loja_virtual_completa/models/usuario_manager.dart';
import 'package:provider/provider.dart';

class CriarContaScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  //FORMA DE NÃO USAR TextEditingController PARA CADA UM DOS CAMPOS
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
            child: Consumer<UsuarioManager>(
              builder: (context, usuarioManager, child) {
                return ListView(
                  shrinkWrap: true, //vai ocupar o menor espaço possível
                  padding: EdgeInsets.all(16),
                  children: [
                    construirCampoNomeCompleto(usuarioManager),
                    const SizedBox(height: 10),
                    construirCampoEmail(usuarioManager),
                    const SizedBox(height: 10),
                    construirCampoSenha(usuarioManager),
                    const SizedBox(height: 10),
                    construirCampoRepitaSenha(usuarioManager),
                    const SizedBox(height: 10),
                    construirBotaoCriarConta(context, usuarioManager),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  TextFormField construirCampoNomeCompleto(UsuarioManager usuarioManager) {
    return TextFormField(
      decoration: InputDecoration(hintText: "Nome Compelto"),
      enabled: !usuarioManager.carregando,
      validator: (valor) {
        if (valor.isEmpty) {
          return "Campo obrigatório";
        } else if (!validarNomeCompleto(valor)) {
          return "Informe o Nome Completo";
        }
        return null;
      },
      onSaved: (valor) => usuario.nome = valor,
    );
  }

  TextFormField construirCampoEmail(UsuarioManager usuarioManager) {
    return TextFormField(
      decoration: InputDecoration(hintText: "E-mail"),
      keyboardType: TextInputType.emailAddress,
      enabled: !usuarioManager.carregando,
      validator: (valor) {
        if (valor.isEmpty) {
          return "Campo obrigatório";
        } else if (!validarEmail(valor)) {
          return "E-mail inválido";
        }
        return null;
      },
      onSaved: (valor) => usuario.email = valor,
    );
  }

  TextFormField construirCampoSenha(UsuarioManager usuarioManager) {
    return TextFormField(
      decoration: InputDecoration(hintText: "Senha"),
      autocorrect: false,
      obscureText: true,
      enabled: !usuarioManager.carregando,
      validator: (valor) {
        if (valor.isEmpty) {
          return "Campo obrigatório";
        } else if (!validarSenha(valor)) {
          return "Senha muito curta";
        }
        return null;
      },
      onSaved: (valor) => usuario.senha = valor,
    );
  }

  TextFormField construirCampoRepitaSenha(UsuarioManager usuarioManager) {
    return TextFormField(
      decoration: InputDecoration(hintText: "Repita a Senha"),
      autocorrect: false,
      obscureText: true,
      enabled: !usuarioManager.carregando,
      validator: (valor) {
        if (valor.isEmpty) {
          return "Campo obrigatório";
        } else if (!validarSenha(valor)) {
          return "Senha muito curta";
        }
        return null;
      },
      onSaved: (valor) => usuario.senhaConfirmar = valor,
    );
  }

  SizedBox construirBotaoCriarConta(BuildContext context, UsuarioManager usuarioManager) {
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
            : Text("Criar Conta"),
        onPressed: () => usuarioManager.carregando ? null : acaoBotaoCriarConta(context, usuarioManager),
      ),
    );
  }

  void acaoBotaoCriarConta(BuildContext context, UsuarioManager usuarioManager) {
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

      //sem o Consumer context.read<UsuarioManager>() e com Consumer usuarioManager
      usuarioManager.criarConta(
        usuario: usuario,
        onSucces: () {
          Navigator.of(context).pop();
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
