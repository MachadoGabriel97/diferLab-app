import 'package:flutter/material.dart';
import 'package:navigator_project/TelaMinhasIdeias.dart';
import 'package:navigator_project/TelaNovaIdeia.dart';

import 'TelaAnotacoes.dart';

class TelaPrincipalRecados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomeScreen(),
      routes: {
        '/novaIdeia': (context) => TelaNovaIdeia(),
        '/minhasIdeias': (context) => TelaMinhasIdeias(),
        '/anotacoes': (context) => TelaAnotacoes(),
        '/recados': (context) => TelaPrincipalRecados(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recados")
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'Seja muito bem-vindo, Gabriel.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Adoramos te acompanhar nessa jornada de criatividade e inspirações. Conte conosco com o que precisar.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 28),
            Image.asset("imagens/logo.png"),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Image.asset("imagens/logo.png"),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.lightbulb_outline),
              title: Text('Nova Ideia'),
              onTap: () {
                Navigator.pushNamed(context, '/novaIdeia');
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Minhas Ideias'),
              onTap: () {
                Navigator.pushNamed(context, '/minhasIdeias');
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Anotações'),
              onTap: () {
                Navigator.pushNamed(context, '/anotacoes');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configurações'),
              onTap: () {
                Navigator.pushNamed(context, '/configuracoes');
              },
            ),
          ],
        ),
      ),
    );
  }
}
