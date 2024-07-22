import 'package:flutter/material.dart';

import 'TelaNovaIdeia.dart';
import 'TelaMinhasIdeias.dart';
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
      routes: {
        '/details': (context) => TelaNovaIdeia(),
        '/details': (context) => TelaMinhasIdeias(),
      },
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
  String recado = """Seja muito bem-vindo, Gabriel.\n Adoramos te acompanhar nessa jornada de criatividade e inspirações. Conte conosco com o que precisar.""";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 40, 38, 71),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("imagens/logo.png"),
            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                recado,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Image.asset("imagens/btn_nova_ideia.png"),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TelaNovaIdeia(),
                        )
                    );
                  },
                ),
                GestureDetector(
                  child: Image.asset("imagens/btn_minhas_ideias.png",),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  TelaMinhasIdeias()
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
                  child: Image.asset("imagens/btn_anotacoes.png"),
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
                  child: Image.asset("imagens/btn_configuracoes.png"),
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
