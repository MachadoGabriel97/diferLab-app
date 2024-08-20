import 'package:flutter/material.dart';

import '../componentes/componenteAppBar.dart';
import '../componentes/componenteMenu.dart';
class GerenciarUsuarios extends StatefulWidget {
  const GerenciarUsuarios({super.key});

  @override
  State<GerenciarUsuarios> createState() => _GerenciarUsuariosState();
}

class _GerenciarUsuariosState extends State<GerenciarUsuarios> {
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
      appBar: ComponenteAppBar(tituloComponente: "Gerenciar Usuarios",usuarioLogado: email),
      drawer: ComponenteMenu(email: email,),
      body: const Column(children: [Text('Tela para gerenciamento dos usuários')],),

    );
  }
}
