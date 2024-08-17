import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AutenticacaoServico {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore storage = FirebaseFirestore.instance;

  cadastrarUsuario({
    required String email,
    required String senha,
  }) {
    try {
      Future<UserCredential> user = firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: senha);
    print(user.toString());
    }catch(e){
      print(e.toString());
    }
  }

  Future<bool> conectarConta({
    required String email,
    required String senha,
  }) async {
    try {
      UserCredential credencialUsuario = await firebaseAuth.signInWithEmailAndPassword(email: email, password: senha);
      print(credencialUsuario.user);
      print(credencialUsuario.credential);

      User? usuario = firebaseAuth.currentUser;

      if (usuario != null) {
        print("retorno: ${credencialUsuario.hashCode.toString()}");
        print("USER: ${credencialUsuario}");
        print("email: ${firebaseAuth.currentUser?.email.toString()}");
        return true;
      }
    } catch (e) {
      print(e.toString());
      sairDaConta();
    }
    return false;
  }

  void enviarEmailRecuperacaoConta(String email){
    try{
      firebaseAuth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }

  }

  void sairDaConta() {
    print('saindo da conta');
    firebaseAuth.signOut();
  }
}
