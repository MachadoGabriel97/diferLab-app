import 'package:flutter/material.dart';
import 'package:navigator_project/TelaMinhasIdeias.dart';
import 'package:navigator_project/TelaNovaIdeia.dart';

import 'TelaAnotacoes.dart';
import 'TelaConfiguracoes.dart';
import 'componenteAppBar.dart';
import 'componenteMenu.dart';

class TelaPrincipalRecados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: HomeScreen(),
      routes: {
        '/novaIdeia': (context) => TelaNovaIdeia(),
        '/minhasIdeias': (context) => TelaMinhasIdeias(),
        '/anotacoes': (context) => TelaAnotacoes(),
        '/recados': (context) => TelaPrincipalRecados(),
        '/configuracoes': (context) => TelaConfiguracoes(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: ComponenteMenu(),
      appBar: ComponenteAppBar(tituloComponente: "Recados"),
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'Seja muito bem-vindo, Gabriel.',
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
