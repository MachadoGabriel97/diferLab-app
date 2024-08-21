import 'package:flutter/material.dart';
import 'package:navigator_project/servicos/ImageService.dart';

class ComponenteAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String tituloComponente;
  final String? usuarioLogado;
  final bool? mostrarIconeMenu;


  const ComponenteAppBar({
    super.key,
    required this.tituloComponente,
    this.mostrarIconeMenu,
    this.usuarioLogado,
  });

  @override
  State<ComponenteAppBar> createState() => _ComponenteAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ComponenteAppBarState extends State<ComponenteAppBar> {
  String? _url;

  @override
  void initState() {
    super.initState();
    if (widget.usuarioLogado != null && widget.usuarioLogado.toString().isNotEmpty) {
      print('Usuario logado: ${widget.usuarioLogado.toString()}');
      buscaImagem();
    }
  }

  @override
  void didUpdateWidget(covariant ComponenteAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.usuarioLogado != widget.usuarioLogado) {
      buscaImagem();
    }
  }

  Future<void> buscaImagem() async {
    try {
      var url = await ImageService.pesquisarUrlDoAvatarPorEmail(widget.usuarioLogado.toString());
      //print('url:$url');
      //print('metodobusca imagem- email:${widget.usuarioLogado.toString()}');
      setState(() {
        _url = url;
      });
    } catch (e) {
      print('Erro ao buscar a URL da imagem: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.tituloComponente,
        style: const TextStyle(color: Colors.white),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white
      ),
      elevation: 10,
      centerTitle: true,
      leading: widget.mostrarIconeMenu!
          ? IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      )
          : IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
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
              const SizedBox(width: 20),
              _url == null
                  ? const CircleAvatar(
                backgroundImage: AssetImage("imagens/cadastro_usuario.png"),
              )
                  :   CircleAvatar(
                backgroundImage: NetworkImage(_url.toString()),
              ),
            ],
          )
              : Container(),
        ),
      ],
      backgroundColor: const Color(0xFF242849),
    );
  }


}

