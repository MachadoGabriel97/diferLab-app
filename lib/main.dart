import 'package:flutter/material.dart';
import 'package:navigator_project/telas/ChatProtocolo.dart';
import 'package:navigator_project/telas/GerenciarIdeias.dart';
import 'package:navigator_project/telas/ImageUploader.dart';
import 'package:navigator_project/telas/TelaLogin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:navigator_project/telas/TelaRecuperarSenha.dart';
import 'firebase_options.dart';
import 'telas/GerenciarUsuarios.dart';
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
          '/anotacoes': (context) => const TelaAnotacoes(),
          '/gerenciar_usuarios': (context) => const GerenciarUsuarios(),
          '/gerenciar_ideias': (context) => const GerenciarIdeias(),
          '/detalhes': (context) => TelaDetalhes(),
          '/chat_protocolo': (context) => ChatProtocolo(),
          '/NovaAnotacao': (context) => TelaNovaAnotacao(),
          '/recados': (context) => TelaPrincipalRecados(),
          '/configuracoes': (context) => const TelaConfiguracoes(),
          '/recuperarSenha': (context) => TelaRecuperarSenha(),
          '/imageupload': (context) => ImageUploader(),
        },
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
      )
  );
}



