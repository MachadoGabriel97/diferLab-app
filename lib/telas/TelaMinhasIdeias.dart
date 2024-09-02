import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navigator_project/componentes/componenteMenu.dart';
import 'package:navigator_project/servicos/CadastroIdeiasServico.dart';
import '../componentes/componenteAppBar.dart';

class TelaMinhasIdeias extends StatefulWidget {
  @override
  State<TelaMinhasIdeias> createState() => _TelaMinhasIdeiasState();
}

class _TelaMinhasIdeiasState extends State<TelaMinhasIdeias> {
  late String email = '';
  List<Map<String, dynamic>> ideias = [];
  String? filtroSituacao; // Variável para armazenar o valor selecionado no filtro

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

  // Método para buscar e filtrar ideias
  Future<List<Map<String, dynamic>>> buscarIdeiasFiltradas() async {
    List<Map<String, dynamic>> todasIdeias = await CadastroIdeiaServico.buscarIdeiasPorUsuario(email);
    if (filtroSituacao == null) {
      return todasIdeias;
    } else {
      return todasIdeias.where((ideia) => ideia['status'] == filtroSituacao).toList();
    }
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Filtros:'),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Selecione uma situação'),
                    key: const Key('filtro_situacao'),
                    value: filtroSituacao,
                    items: const [
                      DropdownMenuItem(value: null, child: Text('Não Filtrar')),
                      DropdownMenuItem(value: 'analise', child: Text('Análise')),
                      DropdownMenuItem(value: 'aprovado', child: Text('Aprovado')),
                      DropdownMenuItem(value: 'em_andamento', child: Text('Em Andamento')),
                      DropdownMenuItem(value: 'concluido', child: Text('Concluído')),
                      DropdownMenuItem(value: 'rejeitado', child: Text('Rejeitado')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        filtroSituacao = value; // Atualiza o filtro
                      });
                    },
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
          future: buscarIdeiasFiltradas(), // Utiliza o método que aplica o filtro
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
              ideias = snapshot.data!;
              return Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child:DataTable(
                          columns: const [
                            DataColumn(label: Center(child:Text('Protocolo'))),
                            DataColumn(label: Center(child:Text('Título'))),
                            DataColumn(label: Center(child:Text('Data Sugestão'))),
                            DataColumn(label: Center(child:Text('Status'))),
                            DataColumn(label: Text('Detalhes')),
                            DataColumn(label: Text('Deletar')),
                          ],
                          rows: ideias.map((ideia) {
                            return DataRow(
                              cells: [
                                DataCell(Center(child: Text(ideia['protocolo']))),
                                DataCell(Center(child: Text(ideia['titulo']))),
                                DataCell(Center(child: Text(DateFormat('dd/MM/yyyy HH:mm').format(ideia['data_cadastro'].toDate())))),
                                DataCell(Center(child: Text(ideia['status']))),
                                DataCell(
                                  IconButton(
                                    icon: const Icon(Icons.search),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/detalhes',
                                        arguments: {
                                          'usuario_email': ideia['usuario_email'],
                                          'protocolo': ideia['protocolo'],
                                          'titulo': ideia['titulo'],
                                          'data_cadastro': ideia['data_cadastro'],
                                          'status': ideia['status'],
                                          'descricao': ideia['descricao'],
                                          'solucao_proposta': ideia['solucao_proposta'],
                                          'beneficios': ideia['beneficios'],
                                        },
                                      );
                                    },
                                  ),
                                ),
                                DataCell(
                                  ideia['status'] == 'analise'
                                      ? IconButton(
                                    icon: const Icon(Icons.delete_forever, color: Colors.red),
                                    onPressed: () async {
                                      bool confirmar = await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text("Confirmação"),
                                          content: const Text("Tem certeza que deseja deletar esta ideia?"),
                                          actions: [
                                            TextButton(
                                              child: const Text("Cancelar"),
                                              onPressed: () => Navigator.of(context).pop(false),
                                            ),
                                            TextButton(
                                              child: const Text("Deletar"),
                                              onPressed: () {
                                                Navigator.of(context).pop(true);
                                                setState(() {});
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                      if (confirmar) {
                                        await CadastroIdeiaServico.deletarIdeia(ideia['protocolo']);
                                      }
                                    },
                                  )
                                      : IconButton(
                                    icon: const Icon(Icons.delete_forever, color: Colors.grey),
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                        backgroundColor: Colors.red,
                                        showCloseIcon: false,
                                        duration: Duration(seconds: 5),
                                        content: Text(
                                            "Protocolo já passou da etapa de análise, não pode mais ser deletado!"),
                                      ));
                                    },
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
    );
  }
}
