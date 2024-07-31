import 'package:firebase_auth/firebase_auth.dart';

class AutenticacaoServico {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  cadastrarUsuario({
    required String email,
    required String senha,
  }) {
    firebaseAuth.createUserWithEmailAndPassword(email: email, password: senha);
  }

  bool conectarConta({
    required String email,
    required String senha,
  }) {
    /// usuario teste - admin@diferlab.com.br
    /// senha: QWas12@#
    Future<UserCredential> credencialUsuario =
        firebaseAuth.signInWithEmailAndPassword(email: email, password: senha);
    User? usuario = firebaseAuth.currentUser;
    try {
      if (usuario != null) {
        print("retorno:${credencialUsuario.hashCode.toString()}");
        print("USER:${credencialUsuario}");
        print("email:${firebaseAuth.currentUser?.email.toString()}");
        return true;
      }
    } catch (e) {
      print(e.toString());
      sairDaConta();
    }
    return false;
  }

  void sairDaConta() {
    firebaseAuth.signOut();
  }
}
