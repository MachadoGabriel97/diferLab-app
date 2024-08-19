import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigator_project/componentes/componenteAppBar.dart';
import 'package:navigator_project/componentes/componenteMenu.dart';
import 'package:navigator_project/servicos/CadastroIdeiasServico.dart';


class TelaNovaIdeia extends StatefulWidget {
  TelaNovaIdeia({super.key});

  @override
  State<TelaNovaIdeia> createState() => _TelaNovaIdeiaState();
}

class _TelaNovaIdeiaState extends State<TelaNovaIdeia> {
  final TextEditingController _controllerTitulo = TextEditingController();
  final TextEditingController _controllerDescricao = TextEditingController();
  final TextEditingController _controllerSolucao = TextEditingController();
  final TextEditingController _controllerBeneficios = TextEditingController();
  bool? selecao_termo = false;
  late String? _email='';
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
      setState(() {
        _email = arguments['email'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  ComponenteMenu(email: _email,),
      appBar:   ComponenteAppBar(tituloComponente: "Nova Ideia",usuarioLogado: _email ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Título',
                ),
                controller: _controllerTitulo,
                maxLength: 30,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Descrição (Problema ou melhoria)',
                ),
                maxLength: 200,
                controller: _controllerDescricao,
                maxLines: 3,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Solução Proposta',
                ),
                maxLength: 200,
                controller: _controllerSolucao,
                maxLines: 3,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Benefícios de implementação',
                ),
                maxLength: 200,
                controller: _controllerBeneficios,
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
              ElevatedButton(
                onPressed: () {
                  CadastroIdeiaServico(
                      titulo: _controllerTitulo.text,
                      descricao: _controllerDescricao.text,
                      solucao_proposta: _controllerSolucao.text,
                      beneficios: _controllerBeneficios.text,
                      aceitaTermoLgdp:  selecao_termo!,
                      data_cadastro: DateTime.now(),
                      usuario_email: _email!);
                  ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                    backgroundColor: Colors.green,
                    showCloseIcon: false,
                    duration:  Duration(seconds: 5),
                    content:  Text(
                        'Cadastro realizado com sucesso!'),
                  ));
                  Navigator.pushReplacementNamed(context, '/minhasIdeias');
                },
                style: const ButtonStyle(
                  backgroundColor:  WidgetStatePropertyAll(Colors.blue),
                ),
                child: const Text('Salvar', style: TextStyle(color: Colors.black),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
