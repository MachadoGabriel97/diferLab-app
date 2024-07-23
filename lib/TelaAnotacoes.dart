import 'package:flutter/material.dart';
import 'package:navigator_project/componenteMenu.dart';

class TelaAnotacoes extends StatefulWidget {
  const TelaAnotacoes({super.key});

  @override
  State<TelaAnotacoes> createState() => _TelaAnotacoesState();
}


class _TelaAnotacoesState extends State<TelaAnotacoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anotações"),
        backgroundColor: Colors.grey,
      ),
      drawer: ComponenteMenu(),
      body: const Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
             Row(
              children: [
                Text("Sem dados para mostrar no momento"),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
               Navigator.pushNamed(context, "/minhasIdeias");
            },
        child: Icon(Icons.note_add,) ,
        tooltip: "Nova anotação",
      ),
    );
  }
}
