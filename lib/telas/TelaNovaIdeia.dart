import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigator_project/componentes/componenteAppBar.dart';
import 'package:navigator_project/componentes/componenteElevatedButton.dart';
import 'package:navigator_project/componentes/componenteMenu.dart';
import 'package:navigator_project/servicos/CadastroIdeiasServico.dart';

class TelaNovaIdeia extends StatefulWidget {
  TelaNovaIdeia({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  State<TelaNovaIdeia> createState() => _TelaNovaIdeiaState();
}

class _TelaNovaIdeiaState extends State<TelaNovaIdeia> {
  late TextEditingController _controllerTitulo = TextEditingController();
  late  TextEditingController _controllerDescricao = TextEditingController();
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
        _controllerTitulo.text = arguments['titulo'];
        _controllerDescricao.text = arguments['descricao'];
        _email = arguments['email'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  ComponenteMenu(email: _email,),
      appBar:   ComponenteAppBar(tituloComponente: "Nova Ideia",mostrarIconeMenu:false,usuarioLogado: _email ),
      body: Container(
        padding: MediaQuery.of(context).size.width > 1000
                  ? EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.20)
                  :EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: widget._formKey,
            child: ListView(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Título',
                  ),
                  controller: _controllerTitulo,
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Campo obrigatório, não deve ser vazio';
                    }
                    return null;
                  },
                  maxLength: 100,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Descrição (Problema ou melhoria)',
                  ),
                  maxLength: 1000,
                  controller: _controllerDescricao,
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Campo obrigatório, não deve ser vazio';
                    }
                    return null;
                  },
                  maxLines: 5,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Solução Proposta',
                  ),
                  maxLength: 1000,
                  controller: _controllerSolucao,
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Campo obrigatório, não deve ser vazio';
                    }
                    return null;
                  },
                  maxLines: 5,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Benefícios de implementação',
                  ),
                  maxLength: 1000,
                  controller: _controllerBeneficios,
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Campo obrigatório, não deve ser vazio';
                    }
                    return null;
                  },
                  maxLines: 5,
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
                ComponenteElevatedButton(
                    formKey: widget._formKey,
                    corDoBotao: Colors.blue,
                    tituloBotao: 'Salvar',
                    funcao: (){
                      if(widget._formKey.currentState!.validate()){
                        CadastroIdeiaServico ideia = CadastroIdeiaServico(
                            titulo: _controllerTitulo.text,
                            descricao: _controllerDescricao.text,
                            solucao_proposta: _controllerSolucao.text,
                            beneficios: _controllerBeneficios.text,
                            aceitaTermoLgdp:  selecao_termo!,
                            data_cadastro: DateTime.now(),
                            usuario_email: _email!, status: 'analise');

                        ideia.inserir();
                        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                          backgroundColor: Colors.green,
                          showCloseIcon: false,
                          duration:  Duration(seconds: 5),
                          content:  Text(
                              'Cadastro realizado com sucesso!'),
                        ));
                        Navigator.pushReplacementNamed(context, '/minhasIdeias',arguments: {'email':_email});
                      }
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
