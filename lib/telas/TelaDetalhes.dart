import 'package:flutter/material.dart';
import 'package:navigator_project/componentes/componenteAppBar.dart';
import 'package:navigator_project/componentes/componenteMenu.dart';

class TelaDetalhes extends StatefulWidget {
  @override
  State<TelaDetalhes> createState() => _TelaDetalhesState();
}

class _TelaDetalhesState extends State<TelaDetalhes> {

  late String? email='';
  late String? protocolo='';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      //final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    setState(() {
      email = arguments['email'];
      protocolo = arguments['protocolo'];
    });
    return Scaffold(
      drawer: ComponenteMenu(email: email,),
      appBar: ComponenteAppBar(tituloComponente: 'Detalhes',mostrarIconeMenu: false,usuarioLogado: email,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              initialValue: protocolo,
              decoration: const InputDecoration(
                labelText: 'Protocolo',
              ),
              readOnly: true,
            ),
            TextFormField(
              initialValue: arguments['date'],
              decoration: const InputDecoration(
                labelText: 'Data Sugestão',
              ),
              readOnly: true,
            ),
            TextFormField(
              initialValue: arguments['status'],
              decoration: const InputDecoration(
                labelText: 'Status',
              ),
              readOnly: true,
            ),

            TextFormField(
              initialValue: arguments['title'],
              decoration: const InputDecoration(
                labelText: 'Título',
              ),
              readOnly: true,
            ),
            TextFormField(
              initialValue: arguments['description'],
              decoration: const InputDecoration(
                labelText: 'Descrição',
              ),
              readOnly: true,
              maxLines: 3,
            ),
            TextFormField(
              initialValue: arguments['proposal'],
              decoration: const InputDecoration(
                labelText: 'Solução Proposta',
              ),
              readOnly: true,
              maxLines: 3,
            ),
            TextFormField(
              initialValue: arguments['benefits'],
              decoration: const InputDecoration(
                labelText: 'Benefícios de implementação',
              ),
              readOnly: true,
              maxLines: 3,
            ),
            TextFormField(
              initialValue: arguments['feedback'],
              decoration: const InputDecoration(
                labelText: 'Feedback Recebido',
              ),
              readOnly: true,
              maxLines: 3,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: (){
          Navigator.pushNamed(context, '/chat_protocolo',arguments: {'protocolo':protocolo,'email':email});
        },
        elevation: 10, child: const Icon(Icons.chat, color: Colors.white,),
        hoverColor: Colors.indigoAccent,
        tooltip: "Ver acompanhamentos",
      ),
    );
  }
}