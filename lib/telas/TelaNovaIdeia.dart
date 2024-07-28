import 'package:flutter/material.dart';
import 'package:navigator_project/componentes/componenteAppBar.dart';
import 'package:navigator_project/componentes/componenteMenu.dart';

enum TermoLgdp {Concordo, Discordo}

class TelaNovaIdeia extends StatefulWidget {
  const TelaNovaIdeia({super.key});

  @override
  State<TelaNovaIdeia> createState() => _TelaNovaIdeiaState();
}

class _TelaNovaIdeiaState extends State<TelaNovaIdeia> {
  TermoLgdp? selecaoTermo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:const ComponenteMenu(),
      appBar:  const ComponenteAppBar(tituloComponente: "Nova Ideia",usuarioLogado: "Gabriel"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Título',
                ),
                maxLength: 30,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Descrição (Problema ou melhoria)',
                ),
                maxLength: 200,
                maxLines: 3,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Solução Proposta',
                ),
                maxLength: 200,
                maxLines: 3,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Benefícios de implementação',
                ),
                maxLength: 200,
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              const Text(
                'Termo da LGPD:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                    "Obs.: Caso não aceite em receber as comunicações por e-mail, será de sua responsabilidade buscar os relatos diretamente com os responsáveis pelo programa."),
              ),
              Column(
                children: [
                  const Row(
                    children: [
                      Text("Aceite do Termo:"),
                    ],
                  ),
                  RadioListTile<TermoLgdp>(
                    title: const Text("Concordo"),
                    value: TermoLgdp.Concordo,
                    groupValue: selecaoTermo,
                    onChanged: (TermoLgdp? valor_selecionado) {
                      setState(() {
                        selecaoTermo = valor_selecionado;
                      });
                    },
                  ),
                  RadioListTile<TermoLgdp>(
                    title: const Text("Discordo"),
                    value: TermoLgdp.Discordo,
                    groupValue: selecaoTermo,
                    onChanged: (TermoLgdp? valor_selecionado) {
                      setState(() {
                        selecaoTermo = valor_selecionado;
                      });
                    },
                  ),

                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
