import 'package:flutter/material.dart';

class ComponenteElevatedButton extends StatelessWidget {

  final Color corDoBotao  ;
  final String tituloBotao;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ComponenteElevatedButton({super.key, required this.formKey, required this.corDoBotao, required this.tituloBotao});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: this.corDoBotao, // Cor do botão
        padding: EdgeInsets.symmetric(vertical: 16),
      ),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
            backgroundColor: Colors.green,
            showCloseIcon: false,
            duration: Duration(seconds: 10),
            content: Text(
                "Dados salvos com sucesso!\n Favor realizar seu login com o usuário e senha criados."),

          ));
          Navigator.pop(context);
        }
      },
      child: Text(this.tituloBotao, style: const TextStyle(color: Colors.white),),
    );
  }
}
