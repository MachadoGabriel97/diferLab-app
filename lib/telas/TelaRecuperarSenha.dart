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

  bool _validatePassword(String password) {
    if (password.length < 8) return false;
    if (!RegExp(r'[A-Za-z]').hasMatch(password)) return false;
    if (!RegExp(r'[0-9]').hasMatch(password)) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF242849), // Cor de fundo definida para hex 242849
      appBar: const ComponenteAppBar(tituloComponente: "Recuperar Conta"),
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
                    SizedBox(
                      width: width,
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                          hintText: 'ex: mr.nobody@yahoo.com',
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
                        fechaTela: true,
                        funcao: (){
                          AutenticacaoServico().enviarEmailRecuperacaoConta(_emailController.text);
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
