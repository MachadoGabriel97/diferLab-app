// image_service_mobile.dart

import 'dart:io';
import 'dart:typed_data';
import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  static final picker = ImagePicker();

  static Future<File?> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('Nenhuma imagem selecionada.');
      return null;
    }
  }

  static Future<String?> uploadImage({File? imageFile, required String email}) async {
    if (imageFile == null) return null;

    try {
      String fileName = imageFile.path.split('/').last; // Nome do arquivo para Mobile
      Reference storageRef = FirebaseStorage.instance.ref().child('avatar_usuarios/$fileName');
      UploadTask uploadTask = storageRef.putFile(imageFile, SettableMetadata(contentType: 'image/jpeg'));

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
