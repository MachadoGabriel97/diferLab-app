import 'package:flutter/material.dart';
import 'package:navigator_project/componentes/componenteAppBar.dart';
import 'package:navigator_project/componentes/componenteElevatedButton.dart';
import 'package:navigator_project/servicos/AutenticacaoServico.dart';

class TelaRecuperarSenha extends StatefulWidget {
  @override
  _TelaRecuperarSenhaState createState() => _TelaRecuperarSenhaState();
}

class _TelaRecuperarSenhaState extends State<TelaRecuperarSenha> {
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF242849), // Cor de fundo definida para hex 242849
      appBar: const ComponenteAppBar(tituloComponente: "Esqueceu sua senha ? ",mostrarIconeMenu: false, ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width =
          constraints.maxWidth > 480 ? 480 : constraints.maxWidth;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 90,
                      child: Text("Informe seu e-mail abaixo para lhe encaminharmos uma mensagem de recuperação de conta.",
                      style: TextStyle(color: Colors.white,fontSize: 16),),
                    ),
                    SizedBox(
                      width: width,
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                          hintText: 'ex: mr.nobody@gmail.com',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira um e-mail';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Por favor, insira um e-mail válido';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: width,
                      child: ComponenteElevatedButton(
                        corDoBotao: const Color(0xFF03A9F4),
                        tituloBotao: "Recuperar conta",
                        formKey: _formKey,
                        mensagem_snackbar: "Favor verique seu e-mail para dar seguimento na recuperação da conta.",
                        funcao: (){
                          AutenticacaoServico().enviarEmailRecuperacaoConta(_emailController.text);
                          Future.delayed(
                              Duration(seconds: 5),() {Navigator.pop(context);},
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
