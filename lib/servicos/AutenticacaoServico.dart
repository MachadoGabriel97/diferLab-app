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

     Future<UserCredential> user =  firebaseAuth.signInWithEmailAndPassword(email: email, password: senha);
     print("retorno:${user.toString()}");
     print("USER:${firebaseAuth.currentUser.toString()}");
     print("email:${firebaseAuth.currentUser?.email.toString()}");

  }

  sairDaConta(){
    firebaseAuth.signOut();
  }

}

