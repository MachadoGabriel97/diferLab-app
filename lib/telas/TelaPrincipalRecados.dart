import 'package:flutter/material.dart';
import 'package:navigator_project/telas/TelaConfiguracoes.dart';
import 'package:navigator_project/telas/TelaMinhasIdeias.dart';
import 'package:navigator_project/telas/TelaNovaAnotacao.dart';
import 'package:navigator_project/telas/TelaNovaIdeia.dart';
import 'TelaAnotacoes.dart';
import '../componentes/componenteAppBar.dart';
import '../componentes/componenteMenu.dart';

class TelaPrincipalRecados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: HomeScreen(),
      title: "DiferLab",
      routes: {
        '/novaIdeia': (context) => TelaNovaIdeia(),
        '/minhasIdeias': (context) => TelaMinhasIdeias(),
        '/anotacoes': (context) => TelaAnotacoes(),
        '/NovaAnotacao': (context) => TelaNovaAnotacao(),
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
      appBar: ComponenteAppBar(tituloComponente: "Recados",usuarioLogado: "Gabriel",),
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
