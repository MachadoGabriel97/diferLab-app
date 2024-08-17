import 'package:cloud_firestore/cloud_firestore.dart';

class ImageService {
  // Método estático para buscar a URL da imagem pelo email
  static Future<String?> pesquisarUrlDoAvatarPorEmail(String email) async {
    try {
      // Consulta à coleção avatar_usuarios onde o campo 'email' corresponde ao email fornecido
      print('email:$email');
      String imageUrl='nourl';
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('avatar_usuarios')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Supondo que a URL da imagem esteja armazenada no campo 'url'
        imageUrl = querySnapshot.docs.first.get('url');
        return imageUrl;
      } else {
        print(imageUrl);
        print('Nenhum documento encontrado para o email fornecido.');
        return null;
      }
    } catch (e) {
      print('Erro ao buscar a URL da imagem: $e');
      return null;
    }
  }
}