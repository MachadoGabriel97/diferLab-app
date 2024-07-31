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
        backgroundColor: this.corDoBotao, // Cor do botão
        padding: EdgeInsets.symmetric(vertical: 16),
      ),
      onPressed: () {
        this.funcao();

        if (formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            backgroundColor: Colors.green,
            showCloseIcon: false,
            duration: Duration(seconds: 10),
            content:  Text(
                mensagem_snackbar),

          ));


        }
        if(this.fechaTela){
          Navigator.pop(context);
        }
      },
      child: Text(this.tituloBotao, style: const TextStyle(color: Colors.white),),
    );
  }
}
