import 'package:flutter/material.dart';
import 'package:navigator_project/TelaNovaIdeia.dart';

class TelaMinhasIdeias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diferlab',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        '/details': (context) => DetailsScreen(),
        '/nova-ideia': (context) => TelaNovaIdeia(),
        /*'/anotacoes': (context) => AnotacoesScreen(), // Nova tela exemplo
        '/configuracoes': (context) => ConfiguracoesScreen(), // Nova tela exemplo*/
        },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.lightbulb_outline),
              title: Text('Nova Ideia'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Minhas Ideias'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.note),
              title: Text('Anotações'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configurações'),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Minhas Ideias'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Filtros
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Data da Sugestão:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(labelText: 'Início', suffixIcon: Icon(Icons.calendar_today)),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(labelText: 'Fim', suffixIcon: Icon(Icons.calendar_today)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Selecione uma situação'),
                    items: [
                      DropdownMenuItem(value: 'Análise', child: Text('Análise')),
                      DropdownMenuItem(value: 'Aprovado', child: Text('Aprovado')),
                      DropdownMenuItem(value: 'Rejeitado', child: Text('Rejeitado')),
                    ],
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Tabela de Ideias
            Expanded(
              child: ListView(
                children: [
                  DataTable(
                    columns: [
                      DataColumn(label: Text('Título')),
                      DataColumn(label: Text('Data Sugestão')),
                      DataColumn(label: Text('Situação')),
                      DataColumn(label: Text('Detalhes')),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text('teste melhoria em algo')),
                        DataCell(Text('20/07/2024')),
                        DataCell(Text('Análise')),
                        DataCell(IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            Navigator.pushNamed(context, '/details', arguments: {
                              'title': 'teste melhoria em algo',
                              'date': '20/07/2024',
                              'status': 'Análise',
                              'description': 'Descrição detalhada da ideia.',
                              'proposal': 'Proposta da ideia.',
                              'benefits': 'Benefícios da implementação.',
                              'feedback': 'Feedback recebido.',
                            });
                          },
                        )),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('teste alguma informação nova')),
                        DataCell(Text('22/07/2024')),
                        DataCell(Text('Aprovado')),
                        DataCell(IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            Navigator.pushNamed(context, '/details', arguments: {
                              'title': 'teste alguma informação nova',
                              'date': '22/07/2024',
                              'status': 'Aprovado',
                              'description': 'Minha descrição complementar para este texto legal do teste da tela sobre o detalhamento da ideia.',
                              'proposal': 'Minha descrição complementar para proposta realizada sobre a solução a ser criada.',
                              'benefits': 'Descrição sobre os benefícios deste solicitação de teste, criar um app muito legal.',
                              'feedback': 'Recebemos feedback positivo sobre a solicitação, garantindo aprovação para avançar. Estamos ansiosos para seguir adiante conforme planejado, cumprindo todos os requisitos estabelecidos.',
                            });
                          },
                        )),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('teste sobre algo')),
                        DataCell(Text('23/07/2024')),
                        DataCell(Text('Rejeitado')),
                        DataCell(IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            Navigator.pushNamed(context, '/details', arguments: {
                              'title': 'teste sobre algo',
                              'date': '23/07/2024',
                              'status': 'Rejeitado',
                              'description': 'Descrição detalhada da ideia rejeitada.',
                              'proposal': 'Proposta da ideia rejeitada.',
                              'benefits': 'Benefícios que não foram aceitos.',
                              'feedback': 'Feedback recebido sobre a rejeição.',
                            });
                          },
                        )),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
            // Paginação
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: () {}, child: Text('Anterior')),
                Row(
                  children: List.generate(5, (index) {
                    return TextButton(
                      onPressed: () {},
                      child: Text((index + 1).toString()),
                    );
                  }),
                ),
                TextButton(onPressed: () {}, child: Text('Próximo')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.lightbulb_outline),
              title: Text('Nova Ideia'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Minhas Ideias'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.note),
              title: Text('Anotações'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configurações'),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Detalhes'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              initialValue: arguments['title'],
              decoration: InputDecoration(
                labelText: 'Título',
              ),
              readOnly: true,
            ),
            TextFormField(
              initialValue: arguments['date'],
              decoration: InputDecoration(
                labelText: 'Data Sugestão',
              ),
              readOnly: true,
            ),
            TextFormField(
              initialValue: arguments['status'],
              decoration: InputDecoration(
                labelText: 'Situação',
              ),
              readOnly: true,
            ),
            TextFormField(
              initialValue: arguments['description'],
              decoration: InputDecoration(
                labelText: 'Descrição',
              ),
              readOnly: true,
              maxLines: 3,
            ),
            TextFormField(
              initialValue: arguments['proposal'],
              decoration: InputDecoration(
                labelText: 'Solução Proposta',
              ),
              readOnly: true,
              maxLines: 3,
            ),
            TextFormField(
              initialValue: arguments['benefits'],
              decoration: InputDecoration(
                labelText: 'Benefícios de implementação',
              ),
              readOnly: true,
              maxLines: 3,
            ),
            TextFormField(
              initialValue: arguments['feedback'],
              decoration: InputDecoration(
                labelText: 'Feedback Recebido',
              ),
              readOnly: true,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
