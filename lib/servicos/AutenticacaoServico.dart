import 'package:firebase_auth/firebase_auth.dart';

class AutenticacaoServico {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  cadastrarUsuario({
    required String email,
    required String senha,
  }) {
    firebaseAuth.createUserWithEmailAndPassword(email: email, password: senha);
  }

  conectarConta({
    required String email,
    required String senha,
  }){
    /// usuario teste - admin@diferlab.com.br
    /// senha: QWas12@#
     Future<UserCredential> user =  firebaseAuth.signInWithEmailAndPassword(email: email, password: senha);
     print("retorno:${user.hashCode.toString()}");
     print("USER:${firebaseAuth.currentUser.toString()}");
     print("email:${firebaseAuth.currentUser?.email.toString()}");

  }

  sairDaConta(){
    firebaseAuth.signOut();
  }

}

