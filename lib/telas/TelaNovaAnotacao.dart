import 'package:flutter/material.dart';
import 'package:navigator_project/componentes/componenteElevatedButton.dart';

import '../componentes/componenteAppBar.dart';
import '../componentes/componenteEditText.dart';
import '../componentes/componenteMenu.dart';
import '../servicos/CadastroAnotacaoServico.dart';

class TelaNovaAnotacao extends StatefulWidget {
  TelaNovaAnotacao({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  State<TelaNovaAnotacao> createState() => _TelaNovaAnotacaoState();
}

class _TelaNovaAnotacaoState extends State<TelaNovaAnotacao> {

  late TextEditingController controllerTitulo = TextEditingController();
  late TextEditingController controllerDescricao = TextEditingController();
  late String email='';

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
      setState(() {
        controllerTitulo = TextEditingController(text: arguments['titulo']);
        controllerDescricao = TextEditingController(text: arguments['descricao']);
        email = arguments['email'];
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const ComponenteMenu(),
      appBar: const ComponenteAppBar(
          tituloComponente: "Nova Anotação", usuarioLogado: "Gabriel"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: widget._formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ComponenteEditText(
                  textoLabel: "Título",
                  valorParametro: 'titulo',
                  tamanhoMaximo: 50,
                  controller: controllerTitulo
              ),
              const SizedBox(height: 16),
              ComponenteEditText(
                  textoLabel: "Descrição",
                  valorParametro: 'descricao',
                  tamanhoMaximo: 500,
                  controller: controllerDescricao
              ),
              const SizedBox(height: 16),
              ComponenteElevatedButton(
                formKey: widget._formKey,
                corDoBotao: Colors.indigoAccent,
                tituloBotao: "Cadastrar",
                fechaTela: false,
                mensagem_snackbar: "Cadastro realizado com sucesso.",
                funcao: () {
                  //valida os campos, caso estejam validos, cadastra.
                  if (widget._formKey.currentState!.validate()) {
                    //chamada ao servico de cadastro da anotacao
                   CadastroAnotacaoServico(
                       descricao: controllerDescricao.text.toString(),
                       titulo: controllerTitulo.text.toString(),
                       data: DateTime.now(),
                       usuario_email: email,
                   );
                   //fecha tela e abre a tela inicial
                   Navigator.popAndPushNamed(context, '/anotacoes');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
