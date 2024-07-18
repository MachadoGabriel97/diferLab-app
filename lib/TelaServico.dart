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
      body: const Center(
        child: Column(
          children: [
            Text("Tela Servico ")
          ],
        ),
      ),
    );
  }
}
