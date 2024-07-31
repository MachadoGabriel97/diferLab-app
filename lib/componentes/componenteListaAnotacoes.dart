import 'package:flutter/material.dart';
import '../servicos/CadastroAnotacaoServico.dart';
import 'package:intl/intl.dart';

class ComponenteListaAnotacoes extends StatelessWidget {
  final String usuarioEmail;

  ComponenteListaAnotacoes({required this.usuarioEmail});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: CadastroAnotacaoServico.buscarAnotacoes(usuarioEmail),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Nenhuma anotação encontrada.'));
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

              return ListTile(
                onTap: () {
                  Navigator.popAndPushNamed(context, '/NovaAnotacao',
                      arguments: {'titulo': anotacao['titulo'], 'descricao': anotacao['descricao']});
                },
                title: Row(children: [
                  Text('Criação: ${dataFormatada}'),
                  Text('  Titulo: ${anotacao['titulo']}' ?? 'Sem título')
                ]),
                subtitle: Text(anotacao['descricao'] ?? 'Sem descrição'),
              );
            },
          );
        }
      },
    );
  }
}
