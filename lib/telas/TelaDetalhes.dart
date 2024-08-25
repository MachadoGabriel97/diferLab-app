import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navigator_project/componentes/componenteAppBar.dart';
import 'package:navigator_project/componentes/componenteElevatedButton.dart';
import 'package:navigator_project/componentes/componenteMenu.dart';

class TelaDetalhes extends StatefulWidget {
  @override
  State<TelaDetalhes> createState() => _TelaDetalhesState();
}

class _TelaDetalhesState extends State<TelaDetalhes> {

  late String? usuario_email='';
  late String? protocolo='';

  @override
  Widget build(BuildContext context) {
    var formulario = GlobalKey<FormState>();
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    setState(() {
      usuario_email = arguments['usuario_email'];
      protocolo = arguments['protocolo'];
    });
    return Scaffold(
      drawer: ComponenteMenu(
        email: usuario_email,
      ),
      appBar: ComponenteAppBar(
        tituloComponente: 'Detalhes',
        mostrarIconeMenu: false,
        usuarioLogado: usuario_email,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 10,),
            Text(
               'Protocolo: $protocolo',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),
            Text(
                'Data de Cadastro: ${DateFormat('dd/MM/yyyy HH:mm')
                    .format(arguments['data_cadastro']
                    .toDate()
                )}'
            ),
            SizedBox(height: 10,),
            Text('Status: ${arguments['status']}'),
            SizedBox(height: 10,),
            Form(
              key: formulario,
                child:
                Column(children: [
                  TextFormField(
                    initialValue: arguments['titulo'],
                    decoration: const InputDecoration(
                      labelText: 'Título',
                    ),
                    readOnly: true,
                  ),
                  TextFormField(
                    initialValue: arguments['descricao'],
                    decoration: const InputDecoration(
                      labelText: 'Descrição',
                    ),
                    readOnly: true,
                    maxLines: 3,
                  ),
                  TextFormField(
                    initialValue: arguments['solucao_proposta'],
                    decoration: const InputDecoration(
                      labelText: 'Solução Proposta',
                    ),
                    readOnly: true,
                    maxLines: 3,
                  ),
                  TextFormField(
                    initialValue: arguments['beneficios'],
                    decoration: const InputDecoration(
                      labelText: 'Benefícios de implementação',
                    ),
                    readOnly: true,
                    maxLines: 3,
                  )
                ],
                ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ComponenteElevatedButton(
                    formKey: formulario,
                    corDoBotao: Colors.green,
                    tituloBotao: 'Editar',
                    funcao: (){

                    }
                )

              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: (){
          Navigator.pushNamed(context, '/chat_protocolo',arguments: {'protocolo':protocolo,'email':usuario_email});
        },
        elevation: 10,
        hoverColor: Colors.indigoAccent,
        tooltip: "Ver acompanhamentos",
        child: const Icon(Icons.chat, color: Colors.white,),
      ),
    );
  }
}