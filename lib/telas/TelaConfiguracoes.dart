import 'package:flutter/material.dart';
import 'package:navigator_project/componentes/componenteAppBar.dart';
import 'package:navigator_project/componentes/componenteEditText.dart';
import 'package:navigator_project/componentes/componenteMenu.dart';

enum Sexo {Masculino, Feminino}

class TelaConfiguracoes extends StatefulWidget {
  const TelaConfiguracoes({super.key});

  @override
  State<TelaConfiguracoes> createState() => _TelaConfiguracoesState();
}

class _TelaConfiguracoesState extends State<TelaConfiguracoes> {
  Sexo? sexo_informado;
  TextEditingController controleNomeColaborador = TextEditingController();
  TextEditingController controleNomeGestor = TextEditingController();
  TextEditingController controleNomeArea = TextEditingController();
  TextEditingController controleEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const ComponenteMenu(),
      appBar: ComponenteAppBar(tituloComponente: "Configurações"),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
              child: Column(
                children: [
                  const CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://yt3.googleusercontent.com/-CFTJHU7fEWb7BYEb6Jh9gm1EpetvVGQqtof0Rbh-VQRIznYYKJxCaqv_9HeBcmJmIsp2vOO9JU=s900-c-k-c0x00ffffff-no-rj",
                      ),
                      maxRadius: 100

                  ),
                  ComponenteEditText(
                    textoLabel: "Colaborador",
                    controller: controleNomeColaborador,
                  ),
                  ComponenteEditText(
                    textoLabel: "Gestor direto",
                    controller: controleNomeGestor,
                  ),
                  ComponenteEditText(
                    textoLabel: "Setor",
                    controller: controleNomeArea,
                  ),
                  ComponenteEditText(
                    textoLabel: "E-mail",
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
                        value: Sexo.Masculino,
                        groupValue: sexo_informado,
                        onChanged: (Sexo? valor_selecionado) {
                          setState(() {
                            sexo_informado = valor_selecionado;
                          });
                        },
                      ),
                      RadioListTile<Sexo>(
                        title: const Text("Feminino"),
                        value: Sexo.Feminino,
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
