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
  late String email='';
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
      setState(() {
        email = arguments['email'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ComponenteAppBar(tituloComponente: "Anotações",mostrarIconeMenu:true,usuarioLogado: email),
      drawer: ComponenteMenu(email: email,),
      body:  SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ComponenteListaAnotacoes(usuarioEmail: email)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
               Navigator.pushReplacementNamed(context, "/NovaAnotacao",arguments: {'email':email,'opcao':'C'});
            },
        tooltip: "Nova anotação",
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.note_add,color: Colors.white,) ,
      ),
    );
  }
}
