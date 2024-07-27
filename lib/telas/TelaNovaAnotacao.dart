import 'package:flutter/material.dart';

import '../componentes/componenteAppBar.dart';
import '../componentes/componenteEditText.dart';
import '../componentes/componenteMenu.dart';


class TelaNovaAnotacao extends StatefulWidget {
  const TelaNovaAnotacao({super.key});


  @override
  State<TelaNovaAnotacao> createState() => _TelaNovaAnotacaoState();
}

class _TelaNovaAnotacaoState extends State<TelaNovaAnotacao> {
  TextEditingController controllerTitulo = TextEditingController();
  TextEditingController controllerDescricao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:ComponenteMenu(),
      appBar:  ComponenteAppBar(tituloComponente: "Nova Anotação",usuarioLogado: "Gabriel"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              ComponenteEditText(
                  textoLabel: "Título",
                  controller: controllerTitulo),

              SizedBox(height: 16),
              ComponenteEditText(
                  textoLabel: "Descrição",
                  controller: controllerDescricao),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
