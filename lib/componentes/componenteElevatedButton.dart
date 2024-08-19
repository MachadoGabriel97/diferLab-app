import 'package:flutter/material.dart';

class ComponenteElevatedButton extends StatelessWidget {

  final Color corDoBotao  ;
  final String tituloBotao;
  final String mensagem_snackbar;
  final VoidCallback funcao;
  final bool fechaTela;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ComponenteElevatedButton({super.key,
    required this.formKey,
    required this.corDoBotao,
    required this.tituloBotao,
    required this.funcao,
    required this.mensagem_snackbar,
    required this.fechaTela
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: corDoBotao, // Cor do botão
        padding: const EdgeInsets.symmetric(vertical: 16),
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
        if(fechaTela){
          Navigator.pop(context);
        }
      },
      child: Text(tituloBotao, style: const TextStyle(color: Colors.white),),
    );
  }
}
