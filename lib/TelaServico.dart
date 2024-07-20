import 'package:flutter/material.dart';

class TelaServico extends StatefulWidget {
  const TelaServico({super.key});

  @override
  State<TelaServico> createState() => _TelaServicoState();
}


class _TelaServicoState extends State<TelaServico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Servicos"),
        backgroundColor: Colors.grey,
      ),
      body:  Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  "imagens/detalhe_servico.png",
                  height: 100,
                  width: 125,
                ),
                const Text(
                  "Serviços da empresa:",
                  style: TextStyle(
                         fontSize: 24,
                         fontStyle: FontStyle.italic,
                         fontWeight: FontWeight.bold,
                          backgroundColor: Colors.cyan
                      ),

                )
              ],
            ),
            const Row(
              children: [
                Text("\nConsultoria\nAcompanhamento de Inventário\nAnálise de custos"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
