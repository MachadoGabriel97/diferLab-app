import 'package:flutter/material.dart';
import 'package:navigator_project/telas/TelaLogin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'telas/TelaAnotacoes.dart';
import 'telas/TelaConfiguracoes.dart';
import 'telas/TelaDetalhes.dart';
import 'telas/TelaMinhasIdeias.dart';
import 'telas/TelaNovaAnotacao.dart';
import 'telas/TelaNovaIdeia.dart';
import 'telas/TelaRecados.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Inicializa Flutter
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MaterialApp(
        initialRoute: '/',
        title: 'DiferLab',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => TelaLogin(),
          '/novaIdeia': (context) => TelaNovaIdeia(),
          '/minhasIdeias': (context) => TelaMinhasIdeias(),
          '/anotacoes': (context) => TelaAnotacoes(),
          '/detalhes': (context) => TelaDetalhes(),
          '/NovaAnotacao': (context) => TelaNovaAnotacao(),
          '/recados': (context) => TelaPrincipalRecados(),
          '/configuracoes': (context) => TelaConfiguracoes(),

        },
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
      )
  );
}



