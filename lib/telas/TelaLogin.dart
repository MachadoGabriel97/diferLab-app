import 'package:flutter/material.dart';
import 'package:navigator_project/servicos/AutenticacaoServico.dart';
import 'package:navigator_project/telas/TelaCadastro.dart';

import 'TelaAnotacoes.dart';
import 'TelaConfiguracoes.dart';
import 'TelaMinhasIdeias.dart';
import 'TelaNovaAnotacao.dart';
import 'TelaNovaIdeia.dart';
import 'TelaPrincipalRecados.dart';

class TelaLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DiferLab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: homeTelaLogin(),
      routes: {
        '/novaIdeia': (context) => TelaNovaIdeia(),
        '/minhasIdeias': (context) => TelaMinhasIdeias(),
        '/anotacoes': (context) => TelaAnotacoes(),
        '/NovaAnotacao': (context) => TelaNovaAnotacao(),
        '/recados': (context) => TelaPrincipalRecados(),
        '/configuracoes': (context) => TelaConfiguracoes(),
        '/login': (context) => TelaLogin(),
      },
    );
  }
}

class homeTelaLogin extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF242849),
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
                      width: double.infinity,
                      height: 200,
                      child: Image.asset('imagens/logo.png'),
                    ),
                    SizedBox(
                      width: width,
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Usuário',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira um usuário';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: width,
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira uma senha';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: width,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5C6BC0),
                          // Cor do botão
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            bool valido = AutenticacaoServico().conectarConta(
                                email: _usernameController.text.toString(),
                                senha: _passwordController.text.toString());
                            if (valido) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TelaPrincipalRecados()));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                backgroundColor: Colors.red,
                                showCloseIcon: false,
                                duration: Duration(seconds: 10),
                                content: Text(
                                    "Dados Inválidos ou não existentes. Favor realizar seu login com o usuário e senha criados."),
                              ));
                            }
                          }
                        },
                        icon: const Icon(Icons.login,
                            color: Colors.white), // Ícone de login
                        label: const Text(
                          'Entrar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: width,
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF03A9F4),
                            // Cor do botão
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TelaCadastro()),
                            );
                          },
                          icon: const Icon(Icons.person_add,
                              color: Colors.white), // Ícone de cadastro
                          label: const Text(
                            'Cadastrar Conta',
                            style: TextStyle(color: Colors.white),
                          )),
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
