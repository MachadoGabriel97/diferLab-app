import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;

class ImageUploader extends StatefulWidget {
  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  File? _imageFile; // Para dispositivos móveis
  Uint8List? _webImage; // Para Web
  String? _imageUrl;
  final picker = ImagePicker();

  late String? email='';
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
      setState(() {
        email = arguments['email'];
      });
    });
  }

  Future pickImage() async {
    if (kIsWeb) {
      pickImageWeb();
    } else {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _imageFile = File(pickedFile.path);
          print(_imageFile.toString());
        } else {
          print('Nenhuma imagem selecionada.');
        }
      });
    }
  }

  void pickImageWeb() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'avatar_usuarios/*';
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files!.isEmpty) return;
      final reader = html.FileReader();

      reader.readAsArrayBuffer(files[0]);
      reader.onLoadEnd.listen((e) {
        setState(() {
          _webImage = reader.result as Uint8List;
        });
      });
    });
  }

  Future uploadImage() async {
    if (kIsWeb && _webImage == null) return;
    if (!kIsWeb && _imageFile == null) return;

    try {
      String fileName;
      UploadTask uploadTask;

      if (kIsWeb) {
        // Web
        fileName = '$email.jpg'; // Pode definir o nome conforme necessário
        uploadTask = FirebaseStorage.instance
            .ref('avatar_usuarios/$fileName')
            .putData(_webImage!);
      } else {
        // Mobile
        fileName = _imageFile!.path.split('/').last;
        Reference storageRef = FirebaseStorage.instance.ref().child('avatar_usuarios/$fileName');
        uploadTask = storageRef.putFile(_imageFile!);
      }

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        _imageUrl = downloadURL;
        print(_imageUrl);
      });

      await FirebaseFirestore.instance.collection('avatar_usuarios').add({'url': downloadURL,'email':email});
    } catch (e) {
      print('Erro ao fazer upload da imagem: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload de Imagem'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _imageUrl == null
                ? CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              child: const Icon(Icons.person, size: 50),
            )
                : CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(_imageUrl.toString()),

            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickImage,
              child: const Text('Selecionar Imagem'),
            ),
            ElevatedButton(
              onPressed: uploadImage,
              child: const Text('Upload Imagem'),
            ),
          ],
        ),
      ),
    );
  }
}

