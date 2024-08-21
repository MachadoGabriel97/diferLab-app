import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../componentes/componenteAppBar.dart';

class ChatProtocolo extends StatefulWidget {
  @override
  _ChatProtocoloState createState() => _ChatProtocoloState();
}

class _ChatProtocoloState extends State<ChatProtocolo> {
  late String email='';
  late String protocolo='';
  final TextEditingController _controller = TextEditingController();
  final CollectionReference _messagesCollection = FirebaseFirestore.instance.collection('mensagens_protocolo');
  
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {

    if (_controller.text.isNotEmpty) {
      _messagesCollection.add({
        'texto_mensagem': _controller.text,
        'email_origem':email,
        'protocolo':protocolo,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _controller.clear();
      _autoReply();
    }
  }

  void _autoReply() {
    List<Map<int,String>> frases =
      [
        {0: 'Olá, estou bem e você ?'},
        {1: 'Se nenhuma ideia vier à cabeça, leve a cabeça às ideias!'},
        {2: 'A questão não é essa, exatamente. Vamos pensar melhor sobre, que tal?'},
        {3: 'O que é raro tem valor; o abundante, não.'},
        {4: 'O sábio torna seu caráter amplo, puro, de modo a poder dar apoio aos outros homens e às coisas.'},
        {5: 'Voaram, lado a lado, sem olhar para trás. O passado, agora, não significava mais nada.'},
        {6: 'Sempre achei que fosse o contrário: você e ela, ao invés de ela e você.'},
        {7: 'Cada vez que o cachorro latia, o gato miava, e o papagaio repetia a última coisa que disse.'},
        {8: 'E nem tudo que é caro realmente custa alguma coisa.'},
        {9: 'Toda vez que ele vem aqui eu fico meio assim, sei lá…'},
        {10: 'E a revolução começou a partir de um beijo interrompido.'},
        {11: 'Eu juro que não sei quem foi, por que você tá falando assim? A honra não consiste em não cair nunca, mas em levantar cada vez que se cai.'},
        {12: 'Ele não queria acreditar. Nunca quis, na verdade. Mas, dessa vez, ele precisou.'},
        {13: 'E é exatamente por isso que a Terra é necessariamente plana!'}
    ];
    String frase = frases.elementAt(Random().nextInt(frases.length)).values.toString();
    print(frase);
    Future.delayed(const Duration(seconds: 1), () {
      _messagesCollection.add({
        'email_origem':'automatico@email.com',
        'texto_mensagem': frase.replaceAll('(', '').replaceAll(')', ''),
        'protocolo':protocolo,
        'timestamp': FieldValue.serverTimestamp(),
      });
    });
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
      setState(() {
        email = arguments['email'];
        protocolo = arguments['protocolo'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ComponenteAppBar(tituloComponente: "Protocolo: $protocolo",mostrarIconeMenu:false,usuarioLogado: email),
      body: Container(
        padding: MediaQuery.of(context).size.width > 1000
            ? EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.30)
            :EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _messagesCollection.where('protocolo',isEqualTo: protocolo).orderBy('timestamp').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

                  if (snapshot.hasError) {
                    print('erro: ${snapshot.error}');
                    return Text('Erro: ${snapshot.error}');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(),);
                  }
                  if (!snapshot.hasData || snapshot.data == null) {
                    return Text('Nenhum dado disponível');
                  }

                  WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
                  return ListView(
                    controller: _scrollController,
                    children: snapshot.data?.docs.map((doc) {
                      var emailOrigem = doc['email_origem'] ?? '';
                      var textoMensagem = doc['texto_mensagem'] ?? 'Mensagem não disponível';
                      var timestamp = doc['timestamp'] != null ? DateFormat('dd/MM/yyyy HH:mm').format(doc['timestamp'].toDate()) : 'Data não disponível';

                      return Align(
                        alignment: emailOrigem == email ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: emailOrigem == email ? Colors.blue[100] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(emailOrigem,style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(textoMensagem),
                              const SizedBox(height: 5),
                              Text(
                                timestamp,
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList() ?? [],
                  );

                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Digite sua mensagem...',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
