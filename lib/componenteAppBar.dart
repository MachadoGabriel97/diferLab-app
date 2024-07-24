

import 'package:flutter/material.dart';

class ComponenteAppBar extends StatefulWidget implements PreferredSizeWidget{
  final String tituloComponente;
  const ComponenteAppBar({
    super.key,
    required this.tituloComponente
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
      title:  Text(widget.tituloComponente),
      centerTitle: true,
      backgroundColor: Colors.blue,
    );
  }
}
