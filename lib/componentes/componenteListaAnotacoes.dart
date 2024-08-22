import 'package:flutter/material.dart';
import '../servicos/CadastroAnotacaoServico.dart';
import 'package:intl/intl.dart';

class ComponenteListaAnotacoes extends StatelessWidget {
  final String usuarioEmail;

  const ComponenteListaAnotacoes({super.key, required this.usuarioEmail});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: CadastroAnotacaoServico.buscarAnotacoes(usuarioEmail),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhuma anotação encontrada.'));
        } else {
          final anotacoes = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: anotacoes.length,
            itemBuilder: (BuildContext context, int index) {
              final anotacao = anotacoes[index];
              // Convertendo o Timestamp para DateTime
              DateTime dateTime = anotacao['data'].toDate();
              // Formatando a data
              String dataFormatada =
                  DateFormat('dd/MM/yyyy HH:mm').format(dateTime);

              return Wrap(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/NovaAnotacao',
                          arguments: {'opcao':'A','documentoId':anotacao['documentoId'],'titulo': anotacao['titulo'], 'descricao': anotacao['descricao'], 'email': usuarioEmail});
                      print(anotacao.toString());
                    },
                    tileColor: Colors.grey[150],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    trailing:  IconButton(
                      onPressed: () async {
                        bool confirmar = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Confirmação"),
                            content: Text("Tem certeza que deseja deletar esta anotação?"),
                            actions: [
                              TextButton(
                                child: Text("Cancelar"),
                                onPressed: () => Navigator.of(context).pop(false),
                              ),
                              TextButton(
                                child: Text("Deletar"),
                                onPressed: () => Navigator.of(context).pop(true),
                              ),
                            ],
                          ),
                        );
                        if(confirmar) {
                          await CadastroAnotacaoServico.deletarAnotacao(anotacao['documentoId']);
                        }


                      },
                      icon: const Icon(Icons.delete_forever, color: Colors.red),
                    ),
                    title: Wrap(children: [
                      Text('Criação: ${dataFormatada}'),
                      Text('  Titulo: ${anotacao['titulo']}')
                    ]),
                    subtitle: Text(anotacao['descricao'] ?? 'Sem descrição'),
                  ),
                  Divider(color: Colors.grey,)
                ],

              );
            },
          );
        }
      },
    );
  }
}
