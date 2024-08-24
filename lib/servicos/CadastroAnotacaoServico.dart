import 'package:cloud_firestore/cloud_firestore.dart';

class CadastroAnotacaoServico {
  String? documentoId;
  final String titulo;
  final String descricao;
  final DateTime data;
  final String usuario_email;

  static final  db = FirebaseFirestore.instance;

  CadastroAnotacaoServico(
      {this.documentoId,
      required this.titulo,
        required this.descricao,
        required this.data,
      required this.usuario_email}) {
    final docRef =
        db.collection("anotacoes").doc();
    docRef.set(toMap()).then((_) {
      print('Documento salvo com ID: ${docRef.id}');
    }).catchError((error) {
      print('Erro ao salvar o documento: $error');
    });
  }

   Map<String, dynamic> toMap() {
    return {
      "titulo": titulo,
      'documentoId': documentoId,
      "descricao": descricao,
      "data":data,
      "usuario_email": usuario_email
    };
  }

  static Future<List<Map<String, dynamic>>> buscarAnotacoes(String email) async {
    List<Map<String, dynamic>> anotacoes = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("anotacoes")
          .where("usuario_email", isEqualTo: email).orderBy("data")
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        anotacoes.add({
          'documentoId': doc.id, // Armazena o documentoId
          'titulo': doc['titulo'],
          'descricao': doc['descricao'],
          'data': doc['data'],
          'usuario_email': doc['usuario_email'],
        });
      }

      if (anotacoes.isEmpty) {
        print('Nenhuma anotação encontrada para o usuário com o e-mail: $email');
      }

    } catch (e) {
      print('Erro ao buscar anotações: $e');
    }
    return anotacoes;
  }

  static Future<void> atualizarAnotacao(String docId, Map<String,dynamic> novosValores) async {
    final docRef = db.collection("anotacoes").doc(docId);
    try {
      await docRef.update(novosValores);
      print('Documento atualizado com sucesso: $docId');
    } catch (error) {
      print('Erro ao atualizar o documento: $error');
    }
  }

  static Future<void> deletarAnotacao(String docId) async {
    final docRef = db.collection("anotacoes").doc(docId);
    try {
      await docRef.delete();
      print('Documento Deletado com sucesso: $docId');
    } catch (error) {
      print('Erro ao atualizar o documento: $error');
    }
  }
}

