import 'package:flutter/material.dart';

import '../componentes/componenteAppBar.dart';
import '../componentes/componenteMenu.dart';
class GerenciarRecados extends StatefulWidget {
  const GerenciarRecados({super.key});

  @override
  State<GerenciarRecados> createState() => _GerenciarRecadosState();
}

class _GerenciarRecadosState extends State<GerenciarRecados> {
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
      appBar: ComponenteAppBar(tituloComponente: "Gerenciar Recados",mostrarIconeMenu:true, usuarioLogado: email),
      drawer: ComponenteMenu(email: email,),
      //todo: criar logica para gerenciar os recados
      body: const Column(children: [Text('Tela para gerenciamento de recados')],),

    );
  }
}
