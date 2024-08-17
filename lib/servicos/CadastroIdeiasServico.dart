import 'package:cloud_firestore/cloud_firestore.dart';

class CadastroIdeiaServico {
  final String titulo;
  final String descricao;
  final String solucao_proposta;
  final String beneficios;
  final bool aceitaTermoLgdp; //true - aceita - false - rejeita
  final DateTime data_cadastro;
  final String usuario_email;

  final db = FirebaseFirestore.instance;

  CadastroIdeiaServico({
      required this.descricao,
      required this.titulo,
      required this.solucao_proposta,
      required this.beneficios,
      required this.aceitaTermoLgdp,
      required this.data_cadastro,
      required this.usuario_email
      })
  {
    final docRef = db.collection("ideias").doc();
    docRef.set(toMap()).then((_) {
      print('Documento salvo com ID: ${docRef.id}');
    }).catchError((error) {
      print('Erro ao salvar o documento: $error');
    });
  }

  Map<String, dynamic> toMap() {
    return {
      "titulo": this.titulo,
      "descricao": this.descricao,
      "solucao_proposta": this.solucao_proposta,
      "beneficios": this.beneficios,
      "data_cadastro":this.data_cadastro,
      "usuario_email": this.usuario_email
    };
  }

  static Future<List<Map<String, dynamic>>> buscarIdeias(String email) async {
    List<Map<String, dynamic>> ideias = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("ideias")
          .where("usuario_email", isEqualTo: email).orderBy("data")
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        ideias.add(doc.data() as Map<String, dynamic>);
      }

      if (ideias.isEmpty) {
        print('Nenhuma anotação encontrada para o usuário com o e-mail: $email.');
      }

    } catch (e) {
      print('Erro ao buscar anotações: $e');
    }
    return ideias;
  }


  Future<void> atualizarIdeia(String docId) async {
    final docRef = db.collection("anotacoes").doc(docId);
    try {
      await docRef.update(toMap());
      print('Documento atualizado com sucesso: $docId');
    } catch (error) {
      print('Erro ao atualizar o documento: $error');
    }
  }

  Future<void> deletarIdeia(String docId) async {
    final docRef = db.collection("anotacoes").doc(docId);
    try {
      await docRef.delete();
      print('Documento Deletado com sucesso: $docId');
    } catch (error) {
      print('Erro ao atualizar o documento: $error');
    }
  }
}

