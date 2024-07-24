import 'package:firebase_auth/firebase_auth.dart';

class AutenticacaoServico {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  cadastrarUsuario({
    required String senha,
    required String email,
  }) {
    firebaseAuth.createUserWithEmailAndPassword(email: email, password: senha);
  }
}
