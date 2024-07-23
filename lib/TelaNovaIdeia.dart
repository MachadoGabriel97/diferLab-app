import 'package:flutter/material.dart';
import 'package:navigator_project/componenteMenu.dart';

class TelaNovaIdeia extends StatefulWidget {
  const TelaNovaIdeia({super.key});

  @override
  State<TelaNovaIdeia> createState() => _TelaNovaIdeiaState();
}

class _TelaNovaIdeiaState extends State<TelaNovaIdeia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:ComponenteMenu(),
      appBar: AppBar(
        title: Text('Nova Ideia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Título',
                ),
                maxLength: 30,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Descrição (Problema ou melhoria)',
                ),
                maxLength: 200,
                maxLines: 3,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Solução Proposta',
                ),
                maxLength: 200,
                maxLines: 3,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Benefícios de implementação',
                ),
                maxLength: 200,
                maxLines: 3,
              ),
              SizedBox(height: 16),
              Text(
                'Termo da LGPD:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                    "Obs.: Caso não aceite em receber as comunicações por e-mail, será de sua responsabilidade buscar os relatos diretamente com os responsáveis pelo programa."),
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('Concordo'),
                      leading: Radio(
                        value: true,
                        groupValue: true,
                        onChanged: (bool? value) {},
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('Discordo'),
                      leading: Radio(
                        value: false,
                        groupValue: true,
                        onChanged: (bool? value) {},
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
