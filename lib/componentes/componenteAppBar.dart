
import 'package:flutter/material.dart';
import 'package:navigator_project/servicos/ImageService.dart';

class ComponenteAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String tituloComponente;
  final String? usuarioLogado;

  const ComponenteAppBar({
    super.key,
    required this.tituloComponente,
    this.usuarioLogado,
  });

  @override
  State<ComponenteAppBar> createState() => _ComponenteAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ComponenteAppBarState extends State<ComponenteAppBar> {
  String? _url; // Use String? para campos que podem ser nulos

  @override
  void initState() {
    super.initState();
    if (widget.usuarioLogado != null) {
      buscaImagem();
    }
  }

  Future<void> buscaImagem() async {
    try {
      String? url = await ImageService.pesquisarUrlDoAvatarPorEmail(widget.usuarioLogado.toString());
      setState(() {
        _url = url;
      });
    } catch (e) {
      print('Erro ao buscar a URL da imagem: $e');
    }
  }

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.tituloComponente,
        style: const TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: widget.usuarioLogado != null
              ? Row(
            children: [
              Text(
                "${widget.usuarioLogado}",
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              const SizedBox(width: 10), // Adiciona um espaçamento entre o texto e o CircleAvatar
              CircleAvatar(

                backgroundImage: _url == null
                    ? const AssetImage("imagens/cadastro_usuario.png") as ImageProvider
                    : NetworkImage(_url.toString()),
              ),
            ],
          )
              : Container(),
        ),
      ],
      backgroundColor: Colors.blue,
    );
  }
}
