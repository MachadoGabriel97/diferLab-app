import 'package:cloud_firestore/cloud_firestore.dart';

class CadastroIdeiaServico {
  late String protocolo;
  final String titulo;
  final String descricao;
  final String solucao_proposta;
  final String status;
  final String beneficios;
  final bool aceitaTermoLgdp; //true - aceita - false - rejeita
  final DateTime data_cadastro;
  final String usuario_email;

  final db = FirebaseFirestore.instance;

  CadastroIdeiaServico({
    required this.descricao,
    required this.titulo,
    required this.status,
    required this.solucao_proposta,
    required this.beneficios,
    required this.aceitaTermoLgdp,
    required this.data_cadastro,
    required this.usuario_email,
  });

  Map<String, dynamic> toMap(String _protocolo) {
    return {
      'protocolo': _protocolo,
      'descricao': descricao,
      'titulo': titulo,
      'status': status,
      'solucao_proposta': solucao_proposta,
      'beneficios': beneficios,
      'aceitaTermoLgdp': aceitaTermoLgdp,
      'data_cadastro': data_cadastro,
      'usuario_email': usuario_email,
    };
  }

  Future<void> inserir() async {
    final docRef = FirebaseFirestore.instance.collection("ideias").doc();
    try {
      await docRef.set(toMap(docRef.id));
      print('Documento salvo com ID: ${docRef.id}');
    } catch (error) {
      print('Erro ao salvar o documento: $error');
    }
  }


  static Future<List<Map<String, dynamic>>> buscarIdeiasPorUsuario(String email) async {
    List<Map<String, dynamic>> ideias = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("ideias")
          .where("usuario_email", isEqualTo: email)
          .orderBy("data_cadastro")
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        ideias.add(
            {'protocolo': doc['protocolo'],
              'descricao': doc['descricao'],
              'titulo': doc['titulo'],
              'status': doc['status'],
              'solucao_proposta': doc['solucao_proposta'],
              'beneficios': doc['beneficios'],
              'aceitaTermoLgdp': doc['aceitaTermoLgdp'],
              'data_cadastro': doc['data_cadastro'],
              'usuario_email': doc['usuario_email']
            });
      }

      if (ideias.isEmpty) {
        print('Nenhuma ideia encontrada para o usuário com o e-mail: $email');
      }

    } catch (e) {
      print('Erro ao buscar ideia: $e');
    }
    return ideias;
  }

  static Future<List<Map<String, dynamic>>> buscarIdeiasGeral() async {
    List<Map<String, dynamic>> ideias = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("ideias")
          .orderBy("data_cadastro")
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        ideias.add(
            {'protocolo': doc['protocolo'],
              'descricao': doc['descricao'],
              'titulo': doc['titulo'],
              'status': doc['status'],
              'solucao_proposta': doc['solucao_proposta'],
              'beneficios': doc['beneficios'],
              'aceitaTermoLgdp': doc['aceitaTermoLgdp'],
              'data_cadastro': doc['data_cadastro'],
              'usuario_email': doc['usuario_email']
            });
      }

      if (ideias.isEmpty) {
        print('Nenhuma ideia  encontrada');
      }

    } catch (e) {
      print('Erro ao buscar ideias: $e');
    }
    return ideias;
  }

  Future<void> atualizarIdeia(String docId) async {
    final docRef = db.collection("ideia").doc(docId);
    try {
      await docRef.update(toMap(docId));
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

