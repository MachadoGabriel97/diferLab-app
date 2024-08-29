import 'package:flutter/material.dart';
import 'package:navigator_project/componentes/componenteAppBar.dart';
import 'package:navigator_project/componentes/componenteEditText.dart';
import 'package:navigator_project/componentes/componenteMenu.dart';
import 'package:navigator_project/servicos/ImageService.dart';

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
      appBar: ComponenteAppBar(tituloComponente: "Configurações",mostrarIconeMenu:true,usuarioLogado: email),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
              child: Column(
                children: [
                  //todo: criar logica para image picker e carregar imagem pro firebase storage
                  GestureDetector(
                    onTap: (){
                      ImageService.pesquisarUrlDoAvatarPorEmail(email.toString());
                    },
                    //Todo: adicionar logica para buscar a imagem do perfil do usuario
                    child: const CircleAvatar(
                        foregroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/diferlab-7aa9f.appspot.com/o/avatar_usuarios%2Fgabrielmachadodasilva97%40gmail.com.png?alt=media&token=4ef9c7be-dd33-46d4-aad6-e5d16339edaf'),
                        maxRadius: 50,
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
                        //todo:Criar logica para salvar/atualizar as configurações do usuario
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
