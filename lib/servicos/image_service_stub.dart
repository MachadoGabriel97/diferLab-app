// image_service_stub.dart

import 'dart:typed_data';

class ImageService {
  static Future<dynamic> pickImage() async {
    throw UnsupportedError('Busca de imagens não é suportada nessa plataforma.');
  }

  static Future<String?> uploadImage({dynamic image, required String email}) async {
    throw UnsupportedError('Envio de imagens não suportado nessa plataforma');
  }

  static pesquisarUrlDoAvatarPorEmail(String string) {}
}
