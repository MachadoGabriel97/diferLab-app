import 'package:flutter/material.dart';

class ComponenteElevatedButton extends StatelessWidget {

  final Color corDoBotao  ;
  final String tituloBotao;
  final String mensagem_snackbar;
  final VoidCallback funcao;


  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ComponenteElevatedButton(
  {super.key,
    required this.formKey,
    required this.corDoBotao,
    required this.tituloBotao,
    required this.funcao,
    required this.mensagem_snackbar,

  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: corDoBotao, // Cor do botão
        padding: const EdgeInsets.all(16),
      ),
      onPressed: () {
        funcao();

        if (formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            backgroundColor: Colors.green,
            showCloseIcon: false,
            duration: const Duration(seconds: 5),
            content:  Text(
                mensagem_snackbar),
          ));
        }
      },
      child: Text(tituloBotao, style: const TextStyle(color: Colors.white),),
    );
  }
}
