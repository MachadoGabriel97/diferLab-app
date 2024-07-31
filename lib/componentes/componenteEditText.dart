import 'package:flutter/material.dart';

class ComponenteEditText extends StatefulWidget {
  final String textoLabel;
  final String valorParametro;
  final TextEditingController controller;
  final int tamanhoMaximo;

  ComponenteEditText(
      {super.key,
      required this.textoLabel,
      required this.controller,
        required this.valorParametro,
      required this.tamanhoMaximo});

  @override
  State<ComponenteEditText> createState() => _ComponenteEditTextState();
}

class _ComponenteEditTextState extends State<ComponenteEditText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        //initialValue:  widget.valorParametro,

        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo é obrigatório';
          }
          return null;
        },
        decoration: InputDecoration(
          label: Text(widget.textoLabel),
        ),
        readOnly: false,
        expands: false,
        minLines: 1,
        maxLines: 10,
        maxLength: widget.tamanhoMaximo,
        controller: widget.controller,
      ),
    );
  }
}
