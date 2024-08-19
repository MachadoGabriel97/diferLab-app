import 'package:flutter/material.dart';
import 'package:navigator_project/componentes/componenteAppBar.dart';
import 'package:navigator_project/componentes/componenteEditText.dart';
import 'package:navigator_project/componentes/componenteMenu.dart';
import 'package:navigator_project/telas/ImageUploader.dart';

enum Sexo {masculino, feminino}

class TelaConfiguracoes extends StatefulWidget {
  const TelaConfiguracoes({super.key});

  @override
  State<TelaConfiguracoes> createState() => _TelaConfiguracoesState();
}

class _TelaConfiguracoesState extends State<TelaConfiguracoes> {

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

  Sexo? sexo_informado;
  TextEditingController controleNomeColaborador = TextEditingController();
  TextEditingController controleNomeGestor = TextEditingController();
  TextEditingController controleNomeArea = TextEditingController();
  TextEditingController controleEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ComponenteMenu(email: email,),
      appBar: ComponenteAppBar(tituloComponente: "Configurações",usuarioLogado: email),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
              child: Column(
                children: [
                  //todo: criar logica para image picker e carregar imagem pro firebase storage
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacementNamed(context, '/imageupload',arguments: {'email':email});
                    },
                    child: const CircleAvatar(
                        backgroundImage: AssetImage("imagens/cadastro_usuario.png"),
                        maxRadius: 100
                    ),
                  ),
                  ComponenteEditText(
                    textoLabel: "Colaborador",
                    valorParametro: 'colaborador',
                    tamanhoMaximo: 30,
                    controller: controleNomeColaborador,
                  ),
                  ComponenteEditText(
                    textoLabel: "Gestor direto",
                    valorParametro: 'gestor_direto',
                    tamanhoMaximo: 30,
                    controller: controleNomeGestor,
                  ),
                  ComponenteEditText(
                    textoLabel: "Setor",
                    valorParametro: 'setor',
                    tamanhoMaximo: 40,
                    controller: controleNomeArea,
                  ),
                  ComponenteEditText(
                    textoLabel: "E-mail",
                     valorParametro: 'email',
                    tamanhoMaximo: 50,
                    controller: controleEmail,
                  ),
                  Column(
                    children: [
                      const Row(
                        children: [
                          Text("Sexo:"),
                        ],
                      ),
                      RadioListTile<Sexo>(
                        title: const Text("Masculino"),
                        value: Sexo.masculino,
                        groupValue: sexo_informado,
                        onChanged: (Sexo? valor_selecionado) {
                          setState(() {
                            sexo_informado = valor_selecionado;
                          });
                        },
                      ),
                      RadioListTile<Sexo>(
                        title: const Text("Feminino"),
                        value: Sexo.feminino,
                        groupValue: sexo_informado,
                        onChanged: (Sexo? valor_selecionado) {
                          setState(() {
                            sexo_informado = valor_selecionado;
                            print(sexo_informado);
                          });
                        },
                      ),
                    ],
                  ),
                  IconButton(
                      tooltip:"Salvar",
                      iconSize: 50,
                      onPressed: () {
                        print(controleNomeColaborador.value.text);
                        print(sexo_informado.toString());
                        //todo:Criar logica para salvar/atualizar as configurações do projeto
                        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                          backgroundColor: Colors.lightGreen,
                          showCloseIcon: true,
                          content: Text(
                              "Dados salvos com sucesso!"),

                        ));
                      }, icon: const Icon(Icons.save)
                  ),
              ],
              ),
            ),

        )
      ,
    );
  }
}
