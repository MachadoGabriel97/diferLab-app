

import 'package:flutter/material.dart';

class ComponenteAppBar extends StatefulWidget implements PreferredSizeWidget{
  final String tituloComponente;
  final String? usuarioLogado;
  const ComponenteAppBar({
    super.key,
    required this.tituloComponente,
    this.usuarioLogado
  });

  @override
  State<ComponenteAppBar> createState() => _ComponenteAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _ComponenteAppBarState extends State<ComponenteAppBar> {
  @override
  AppBar build(BuildContext context) {
    return AppBar(
      title:  Text(widget.tituloComponente,
      style: TextStyle(color: Colors.white),),
      centerTitle: true,
      actions: [
        SizedBox(
          height: 20,
          child: Text("Usuário: ${widget.usuarioLogado}", style: const TextStyle(color: Colors.white),),
        )

      ],
      backgroundColor: Colors.blue,
    );
  }
}
