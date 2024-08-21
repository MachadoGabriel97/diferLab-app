import 'package:flutter/material.dart';
import 'package:navigator_project/componentes/componenteMenu.dart';
import '../componentes/componenteAppBar.dart';

class TelaMinhasIdeias extends StatefulWidget {
  @override
  State<TelaMinhasIdeias> createState() => _TelaMinhasIdeiasState();
}

class _TelaMinhasIdeiasState extends State<TelaMinhasIdeias> {
  late String? email='';

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
      appBar:   ComponenteAppBar(tituloComponente: "Minhas Ideias",mostrarIconeMenu:true,usuarioLogado: email),
      drawer:  ComponenteMenu(email: email,),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.lightbulb_outline,color: Colors.yellowAccent,),
          backgroundColor: const Color(0xFF242849),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          tooltip: "Nova Idéia",
          hoverColor: const Color(0xFF373C86) ,
          onPressed: (){ Navigator.pushNamed(context, '/novaIdeia', arguments: {'email': email});}
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            //carregar_filtros(),
            carregar_tabela(),
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
                children: [
                  const Text('Data da Sugestão:', style: TextStyle(fontWeight: FontWeight.bold)),

                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Início',
                        suffixIcon: Icon(Icons.calendar_today)),
                  ),

                  const SizedBox(width: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Fim',
                        suffixIcon: Icon(Icons.calendar_today)),
                  ),
                  const SizedBox(width: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Selecione uma situação'),
                    items: const [
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
    );
  }

  Widget carregar_tabela() {
    return  Expanded(
      child: ListView(
        children: [
          DataTable(
            //Define o cabeçalho da tabela
            columns: const [
              DataColumn(label: Text('Título')),
              DataColumn(label: Text('Data Sugestão')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Detalhes')),
            ],
            //todo: implementar logica para carregar as idéias de acordo com o e-mail do usuário logado
            rows: [
               DataRow(cells: [
                const DataCell(Wrap(children: [Text('teste melhoria em algo')],)),
                const DataCell(Wrap(children: [Text('20/07/2024')],)),
                const DataCell(Wrap(children: [Text('Análise')],)),
                DataCell( IconButton(
                  icon: const Icon(Icons.search),
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
              DataRow(cells: [
                const DataCell(Wrap(children: [Text('teste 2 melhoria em algo')],)),
                const DataCell(Wrap(children: [Text('21/07/2024')],)),
                const DataCell(Wrap(children: [Text('Rejeitado')],)),
                DataCell( IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    Navigator.pushNamed(context, '/detalhes', arguments: {
                      'title': 'teste 2 melhoria em algo',
                      'date': '21/07/2024',
                      'status': 'Rejeitado',
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
    );
  }
}




