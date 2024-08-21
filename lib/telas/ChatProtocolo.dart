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
    Future.delayed(const Duration(seconds: 1), () {
      _messagesCollection.add({
        'email_origem':'automatico@email.com',
        'texto_mensagem': 'Esta é uma resposta automática.',
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
