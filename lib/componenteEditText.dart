import 'package:flutter/material.dart';

class ComponenteEditText extends StatefulWidget {
  final String textoLabel;
  final TextEditingController controller;

  ComponenteEditText({
    super.key,
    required this.textoLabel,
    required this.controller,
  });

  @override
  State<ComponenteEditText> createState() => _ComponenteEditTextState();
}

class _ComponenteEditTextState extends State<ComponenteEditText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onSubmitted: (v) {},
        decoration: InputDecoration(
          label: Text(widget.textoLabel),
        ),
        readOnly: false,
        maxLength: 50,
        controller: widget.controller,
      ),
    );
  }
}
