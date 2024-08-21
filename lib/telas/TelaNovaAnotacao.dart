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
  late String opcao='C';//A-Atualizar - C-Cadastrar
  late String documentoId ='';
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
      setState(() {
        if(arguments['opcao']=='A'){
          controllerTitulo = TextEditingController(text: arguments['titulo']);
          controllerDescricao = TextEditingController(text: arguments['descricao']);
          documentoId  = arguments['documentoId'];
        }
        opcao = arguments['opcao'];
        email = arguments['email'];
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ComponenteMenu(email: email,),
      appBar:  ComponenteAppBar(
          tituloComponente: "Nova Anotação",mostrarIconeMenu:false, usuarioLogado: email),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: widget._formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              documentoId != '' ? Text('Identificador: $documentoId',style: const TextStyle(fontWeight: FontWeight.bold),): const Text(''),
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
                corDoBotao: opcao=='C'? Colors.lightBlue : Colors.green,
                tituloBotao: opcao=='C'? "Cadastrar" : 'Atualizar',
                mensagem_snackbar: opcao=='C'? "Cadastro realizado com sucesso." : "Atualizado com sucesso.",
                funcao: () {
                  //valida os campos, caso estejam validos, cadastra.
                  if (widget._formKey.currentState!.validate()) {
                    //chamada ao servico de cadastro da anotacao
                    Map<String,dynamic> novosValores = {};
                    novosValores['titulo'] =  controllerTitulo.text.toString();
                    novosValores['descricao'] =   controllerDescricao.text.toString();
                    novosValores['data'] =   DateTime.now();
                    if(opcao=='C'){
                      CadastroAnotacaoServico(
                        descricao: controllerDescricao.text.toString(),
                        titulo: controllerTitulo.text.toString(),
                        data: DateTime.now(),
                        usuario_email: email,
                      );
                    }else{
                      CadastroAnotacaoServico.atualizarAnotacao(documentoId, novosValores);
                    }
                   Navigator.pushReplacementNamed(context, '/anotacoes',arguments: {'email': email});
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
