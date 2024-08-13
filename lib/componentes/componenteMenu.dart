
import 'package:flutter/material.dart';
import 'package:navigator_project/servicos/AutenticacaoServico.dart';

class ComponenteMenu extends StatefulWidget {

  const ComponenteMenu({super.key});

  @override
  State<ComponenteMenu> createState() => _ComponenteMenuState();
}

class _ComponenteMenuState extends State<ComponenteMenu> {

  late String email;

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
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Image.asset("imagens/logo.png"),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.mark_unread_chat_alt_outlined),
            title: Text('Recados'),
            onTap: () {
              Navigator.pushNamed(context, '/recados');
            },
          ),
          ListTile(
            leading: Icon(Icons.lightbulb_outline),
            title: Text('Nova Ideia'),
            onTap: () {
              Navigator.pushNamed(context, '/novaIdeia');
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Minhas Ideias'),
            onTap: () {
              Navigator.pushNamed(context, '/minhasIdeias');
            },
          ),
          ListTile(
            leading: Icon(Icons.note_rounded),
            title: Text('Anotações'),
            onTap: () {
              Navigator.pushNamed(context, '/anotacoes',arguments: {'email':email});
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurações'),
            onTap: () {
              Navigator.pushNamed(context, '/configuracoes');
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
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
