// image_service_web.dart

import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageService {
  static Future<Uint8List?> pickImage() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    final completer = Completer<Uint8List?>();
    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files!.isEmpty) {
        completer.complete(null);
        return;
      }
      final reader = html.FileReader();
      reader.readAsArrayBuffer(files[0]);
      reader.onLoadEnd.listen((e) {
        completer.complete(reader.result as Uint8List);
      });
    });

    return completer.future;
  }

  static Future<String?> uploadImage({Uint8List? webImage, required String email}) async {
    if (webImage == null) return null;

    try {
      String fileName = '$email.png'; // Nome do arquivo para Web
      UploadTask uploadTask = FirebaseStorage.instance
          .ref('avatar_usuarios/$fileName')
          .putData(webImage, SettableMetadata(contentType: 'image/png'));

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('avatar_usuarios').add({'url': downloadURL, 'email': email});

      return downloadURL;
    } catch (e) {
      print('Erro ao fazer upload da imagem: $e');
      return null;
    }
  }

  static Future<String?> pesquisarUrlDoAvatarPorEmail(String email) async {
    try {
      String imageUrl = 'nourl';
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('avatar_usuarios')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        imageUrl = querySnapshot.docs.first.get('url');
        return imageUrl;
      } else {
        return null;
      }
    } catch (e) {
      print('Erro ao buscar a URL da imagem: $e');
      return null;
    }
  }
}
