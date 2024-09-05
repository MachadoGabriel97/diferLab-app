import 'package:flutter/material.dart';

import '../componentes/componenteAppBar.dart';
import '../componentes/componenteMenu.dart';

class TelaPrincipalRecados extends StatefulWidget {


  @override
  State<TelaPrincipalRecados> createState() => _TelaPrincipalRecadosState();
}

class _TelaPrincipalRecadosState extends State<TelaPrincipalRecados> {
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
    return   Scaffold(
        drawer:   ComponenteMenu(email: email,),
        appBar: ComponenteAppBar(
          tituloComponente: "Recados", mostrarIconeMenu:true,
          usuarioLogado: email,),
        backgroundColor: const Color(0xFF242849),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    criarCard('Seja bem-vindo!',),
                    criarCard(" Adoramos te acompanhar nessa jornada de criatividade e inspirações.\n\nConte conosco com o que precisar.\n\nEquipe Gente e Cultura (Diferpan - Matriz)',"),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }

  Widget criarCard(String texto) {
    return  Card(
      margin: EdgeInsets.all(32),
      shadowColor: Colors.black,
      elevation: 2.0,
      color: Colors.white,
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(16),
            child: Text(
              texto,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }



}