
import 'package:flutter/material.dart';

class ComponenteMenu extends StatefulWidget {
  const ComponenteMenu({super.key});

  @override
  State<ComponenteMenu> createState() => _ComponenteMenuState();
}

class _ComponenteMenuState extends State<ComponenteMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
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
              Navigator.pushNamed(context, '/anotacoes');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurações'),
            onTap: () {
              Navigator.pushNamed(context, '/configuracoes');
            },
          ),
        ],
      ),
    );
  }
}
