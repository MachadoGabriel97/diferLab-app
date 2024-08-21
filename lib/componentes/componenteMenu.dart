import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:navigator_project/servicos/AutenticacaoServico.dart';

class ComponenteMenu extends StatefulWidget {
  final String? email;

  ComponenteMenu({super.key, required this.email});

  @override
  _ComponenteMenuState createState() => _ComponenteMenuState();
}

class _ComponenteMenuState extends State<ComponenteMenu> {
  bool ehAdmin = false; // ADMIN - true - usuário comum - false

  @override
  void initState() {
    super.initState();
    // Chama a função para buscar o valor de ehAdmin
    buscarEhAdmin();
  }

  Future<void> buscarEhAdmin() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('usuarios')
          .where("email", isEqualTo: widget.email)
          .get();
      if (snapshot.docs.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> doc = snapshot.docs.first;
        setState(() {
          ehAdmin = doc.data()?['ehAdmin'] ?? false;
        });
      } else {
        print('Nenhum documento encontrado com o e-mail fornecido.');
      }
    } catch (e) {
      print('Erro ao buscar o valor de ehAdmin: $e');
    }
  }

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
            child: Text(widget.email!),
          ),
          ListTile(
            leading: const Icon(Icons.mark_unread_chat_alt_outlined),
            title: const Text('Recados'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/recados', arguments: {'email': widget.email});
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Minhas Ideias'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/minhasIdeias', arguments: {'email': widget.email});
            },
          ),
          ListTile(
            leading: const Icon(Icons.note_rounded),
            title: const Text('Anotações'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/anotacoes', arguments: {'email': widget.email});
            },
          ),
          userAdmin(),
          const Divider(color: Colors.black),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/configuracoes', arguments: {'email': widget.email});
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

  Widget userAdmin() {
    return ehAdmin
        ? Column(
      children: [
        const Divider(color: Colors.black),
        ExpansionTile(
          title: const Text('Gerenciar'),
          leading:  Icon(Icons.admin_panel_settings),// Título do ExpansionTile
          children: [
            ListTile(
              leading: const Icon(Icons.perm_contact_cal),
              title: const Text('Usuários'),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context,
                    '/gerenciar_usuarios',
                    arguments: {'email': widget.email}
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Recados'),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context,
                    '/gerenciar_recados',
                    arguments: {'email': widget.email}
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.lightbulb_sharp),
              title: const Text('Ideias'),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context,
                    '/gerenciar_ideias',
                    arguments: {'email': widget.email}
                );
              },
            ),
          ],
        ),
      ],
    )
        : Container();
  }
}
