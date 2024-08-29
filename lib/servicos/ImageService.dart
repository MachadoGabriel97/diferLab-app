import 'dart:typed_data';
import 'dart:io';
import 'dart:html' as html;
import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ImageService {
  static final picker = ImagePicker();

  static Future<File?> pickImageMobile() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('Nenhuma imagem selecionada.');
      return null;
    }
  }

  static Future<Uint8List?> pickImageWeb() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'avatar_usuarios/*';
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

  static Future<String?> uploadImage({File? imageFile, Uint8List? webImage, required String email}) async {
    if (kIsWeb && webImage == null) return null;
    if (!kIsWeb && imageFile == null) return null;

    try {
      String fileName;
      UploadTask uploadTask;

      if (kIsWeb) {
        fileName = '$email.png'; // Nome do arquivo para Web
        uploadTask = FirebaseStorage.instance
            .ref('avatar_usuarios/$fileName')
            .putData(webImage!, SettableMetadata(contentType: 'image/png'));
      } else {
        fileName = imageFile!.path.split('/').last; // Nome do arquivo para Mobile
        Reference storageRef = FirebaseStorage.instance.ref().child('avatar_usuarios/$fileName');
        uploadTask = storageRef.putFile(imageFile, SettableMetadata(contentType: 'image/jpeg'));
      }

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
