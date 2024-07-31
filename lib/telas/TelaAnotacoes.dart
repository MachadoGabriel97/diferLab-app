import 'package:flutter/material.dart';
import 'package:navigator_project/componentes/componenteAppBar.dart';
import 'package:navigator_project/componentes/componenteMenu.dart';

import '../componentes/componenteListaAnotacoes.dart';

class TelaAnotacoes extends StatefulWidget {
  const TelaAnotacoes({super.key});

  @override
  State<TelaAnotacoes> createState() => _TelaAnotacoesState();
}


class _TelaAnotacoesState extends State<TelaAnotacoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ComponenteAppBar(tituloComponente: "Anotações",usuarioLogado: "Gabriel"),
      drawer: ComponenteMenu(),
      body:  SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ComponenteListaAnotacoes(usuarioEmail: "admin@diferlab.com.br")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
               Navigator.pushNamed(context, "/NovaAnotacao");
            },
        child: Icon(Icons.note_add,) ,
        tooltip: "Nova anotação",
      ),
    );
  }
}
