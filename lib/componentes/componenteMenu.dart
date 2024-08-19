
import 'package:flutter/material.dart';
import 'package:navigator_project/servicos/AutenticacaoServico.dart';

class ComponenteMenu extends StatelessWidget {
  final String? email;
  const ComponenteMenu({super.key,required this.email});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF242849),
            ),
            child: Image.asset("imagens/logo.png"),
          ),
          Center(
            child: Text(email!),
          ),
          ListTile(
            leading: const Icon(Icons.mark_unread_chat_alt_outlined),
            title: const Text('Recados'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/recados',arguments: {'email':email});
            },
          ),
          ListTile(
            leading: const Icon(Icons.lightbulb_outline),
            title: const Text('Nova Ideia'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/novaIdeia',arguments: {'email':email});
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Minhas Ideias'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/minhasIdeias',arguments: {'email':email});
            },
          ),
          ListTile(
            leading: const Icon(Icons.note_rounded),
            title: const Text('Anotações'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/anotacoes',arguments: {'email':email});
            },
          ),
          Divider(color: Colors.black,),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/configuracoes',arguments: {'email':email});
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            onTap: () {
              AutenticacaoServico().sairDaConta();
              Navigator.popAndPushNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}



