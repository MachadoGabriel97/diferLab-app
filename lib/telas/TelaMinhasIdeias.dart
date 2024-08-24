import 'package:flutter/material.dart';
import 'package:navigator_project/componentes/componenteMenu.dart';
import 'package:navigator_project/servicos/CadastroIdeiasServico.dart';
import '../componentes/componenteAppBar.dart';

class TelaMinhasIdeias extends StatefulWidget {
  @override
  State<TelaMinhasIdeias> createState() => _TelaMinhasIdeiasState();
}

class _TelaMinhasIdeiasState extends State<TelaMinhasIdeias> {
  late String email = '';

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
      appBar: ComponenteAppBar(
          tituloComponente: "Minhas Ideias",
          mostrarIconeMenu: true,
          usuarioLogado: email),
      drawer: ComponenteMenu(email: email),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF242849),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          tooltip: "Nova Idéia",
          hoverColor: const Color(0xFF373C86),
          onPressed: () {
            Navigator.pushNamed(context, '/novaIdeia',
                arguments: {'email': email, 'titulo': '', 'descricao': ''});
          },
          child: const Icon(
            Icons.lightbulb_outline,
            color: Colors.yellowAccent,
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            carregar_filtros(),
            carregar_tabela()
          ],
        ),
      ),
    );
  }

  Widget carregar_filtros() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Filtros:'),
                  DropdownButtonFormField<String>(
                    decoration:
                    const InputDecoration(labelText: 'Selecione uma situação'),
                    items: const [
                      DropdownMenuItem(value: null, child: Text('Não Filtrar')),
                      DropdownMenuItem(value: 'analise', child: Text('Análise')),
                      DropdownMenuItem(value: 'aprovado', child: Text('Aprovado')),
                      DropdownMenuItem(value: 'em_andamento', child: Text('Em Andamento')),
                      DropdownMenuItem(value: 'concluido', child: Text('Concluido')),
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
    );
  }

  Widget carregar_tabela() {
    return Expanded(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: CadastroIdeiaServico.buscarIdeiasGeral(),
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Erro: ${snapshot.error}');
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print('Nenhuma Ideia encontrada.');
            return const Center(child: Text('Nenhuma Ideia encontrada.'));
          } else {
            final ideias = snapshot.data!;
            print('Ideias carregadas: $ideias');
            return ListView(
              children: [
                DataTable(
                  columns: const [
                    DataColumn(label: Text('Protocolo')),
                    DataColumn(label: Text('Título')),
                    DataColumn(label: Text('Data Sugestão')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Detalhes')),
                  ],
                  rows: ideias.map((ideia) {
                    return DataRow(
                      cells: [
                        DataCell(Wrap(children: [Text(ideia['protocolo'])])),
                        DataCell(Wrap(children: [Text(ideia['title'])])),
                        DataCell(Wrap(children: [Text(ideia['date'])])),
                        DataCell(Wrap(children: [Text(ideia['status'])])),
                        DataCell(
                          IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              Navigator.pushNamed(context, '/detalhes', arguments: {
                                'email': ideia['email'],
                                'protocolo': ideia['protocolo'],
                                'title': ideia['title'],
                                'date': ideia['date'],
                                'status': ideia['status'],
                                'description': ideia['description'],
                                'proposal': ideia['proposal'],
                                'benefits': ideia['benefits'],
                                'feedback': ideia['feedback'],
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
