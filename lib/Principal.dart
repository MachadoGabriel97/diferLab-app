import 'package:flutter/material.dart';
import 'package:navigator_project/TelaCliente.dart';

import 'TelaContato.dart';
import 'TelaEmpresa.dart';
import 'TelaServico.dart';

class PrincipalApp extends StatelessWidget {
  const PrincipalApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tela Inicial',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const Principal(title: 'Tela Inicial'),
    );
  }
}

class Principal extends StatefulWidget {
  const Principal({super.key, required this.title});
  final String title;

  @override
  State<Principal> createState() => _PrincipalPageState();
}


class _PrincipalPageState extends State<Principal> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("imagens/logo.png"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Image.asset("imagens/menu_cliente.png"),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TelaCliente()
                        )
                    );
                  },
                ),
                GestureDetector(
                  child: Image.asset("imagens/menu_contato.png"),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TelaContato()
                        )
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Image.asset("imagens/menu_servico.png"),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TelaServico()
                        )
                    );
                  },
                ),
                GestureDetector(
                  child: Image.asset("imagens/menu_empresa.png"),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TelaEmpresa()
                        )
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
