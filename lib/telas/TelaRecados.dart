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
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      'Seja bem-vindo!',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Adoramos te acompanhar nessa jornada de criatividade e inspirações.\n\nConte conosco com o que precisar.\n\nEquipe Gente e Cultura (Diferpan - Matriz)',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 28),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }


}