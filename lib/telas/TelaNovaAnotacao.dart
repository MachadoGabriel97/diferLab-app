import 'package:flutter/material.dart';
import 'package:navigator_project/componentes/componenteElevatedButton.dart';

import '../componentes/componenteAppBar.dart';
import '../componentes/componenteEditText.dart';
import '../componentes/componenteMenu.dart';


class TelaNovaAnotacao extends StatefulWidget {
  TelaNovaAnotacao({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  State<TelaNovaAnotacao> createState() => _TelaNovaAnotacaoState();
}

class _TelaNovaAnotacaoState extends State<TelaNovaAnotacao> {
  TextEditingController controllerTitulo = TextEditingController();
  TextEditingController controllerDescricao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const ComponenteMenu(),
      appBar: const ComponenteAppBar(tituloComponente: "Nova Anotação",usuarioLogado: "Gabriel"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              ComponenteEditText(
                  textoLabel: "Título",
                  controller: controllerTitulo),

              const SizedBox(height: 16),
              ComponenteEditText(
                  textoLabel: "Descrição",
                  controller: controllerDescricao),
              const SizedBox(height: 16),
             ComponenteElevatedButton(
                 formKey: widget._formKey,
                 corDoBotao: Colors.indigoAccent,
                 tituloBotao: "Cadastrar"),
            ],
          ),
        ),
      ),
    );
  }
}
