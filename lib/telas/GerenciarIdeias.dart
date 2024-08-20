import 'package:flutter/material.dart';

import '../componentes/componenteAppBar.dart';
import '../componentes/componenteMenu.dart';
class GerenciarIdeias extends StatefulWidget {
  const GerenciarIdeias({super.key});

  @override
  State<GerenciarIdeias> createState() => _GerenciarIdeiasState();
}

class _GerenciarIdeiasState extends State<GerenciarIdeias> {
  late String email='';
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
      appBar: ComponenteAppBar(tituloComponente: "Gerenciar Ideias",usuarioLogado: email),
      drawer: ComponenteMenu(email: email,),
      body: const Column(children: [Text('Tela para gerenciamento e acompanhamento de ideias')],),

    );
  }
}
