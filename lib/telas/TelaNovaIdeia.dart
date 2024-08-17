import 'package:flutter/material.dart';
import 'package:navigator_project/componentes/componenteAppBar.dart';
import 'package:navigator_project/componentes/componenteMenu.dart';


class TelaNovaIdeia extends StatefulWidget {
  TelaNovaIdeia({super.key});

  @override
  State<TelaNovaIdeia> createState() => _TelaNovaIdeiaState();
}

class _TelaNovaIdeiaState extends State<TelaNovaIdeia> {
  bool? selecao_termo;
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
      drawer:  ComponenteMenu(email: email,),
      appBar:   ComponenteAppBar(tituloComponente: "Nova Ideia",usuarioLogado: email ),
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
                  RadioListTile<bool>(
                    title: const Text("Concordo"),
                    value: true,
                    groupValue: selecao_termo,
                    onChanged: (bool? valor_selecionado) {
                      setState(() {
                        selecao_termo = valor_selecionado;
                      });
                    },
                  ),
                  RadioListTile<bool>(
                    title: const Text("Discordo"),
                    value: false,
                    groupValue: selecao_termo,
                    onChanged: (bool? valor_selecionado) {
                      setState(() {
                        selecao_termo = valor_selecionado;
                      });
                    },
                  ),

                ],
              ),
              const SizedBox(height: 16),
              //Todo: implementar logica para cadastrar a nova ideia.
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
