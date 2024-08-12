import 'package:flutter/material.dart';
import 'package:navigator_project/componentes/componenteMenu.dart';
import '../componentes/componenteAppBar.dart';
import 'TelaDetalhes.dart';

class TelaMinhasIdeias extends StatefulWidget {
  @override
  State<TelaMinhasIdeias> createState() => _TelaMinhasIdeiasState();
}

class _TelaMinhasIdeiasState extends State<TelaMinhasIdeias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:  const ComponenteAppBar(tituloComponente: "Minhas Ideias",usuarioLogado: "Gabriel"),
      drawer: const ComponenteMenu(),
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
                      Column(
                        children: [
                          Text('Data da Sugestão:', style: TextStyle(fontWeight: FontWeight.bold)),

                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Início',
                                suffixIcon: Icon(Icons.calendar_today)),
                          ),

                          SizedBox(width: 16),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Fim',
                                suffixIcon: Icon(Icons.calendar_today)),
                          ),
                          SizedBox(width: 16),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(labelText: 'Selecione uma situação'),
                            items: [
                              DropdownMenuItem(value: null, child: Text('Não Filtrar')),
                              DropdownMenuItem(value: 'analise', child: Text('Análise')),
                              DropdownMenuItem(value: 'aprovado', child: Text('Aprovado')),
                              DropdownMenuItem(value: 'rejeitado', child: Text('Rejeitado')),
                            ],
                            onChanged: (value) {},
                          )
                        ],
                      ),
                    ],
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
                            Navigator.pushNamed(context, '/detalhes', arguments: {
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
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




