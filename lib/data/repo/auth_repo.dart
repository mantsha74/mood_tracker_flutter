import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final _auth = FirebaseAuth.instance;
  Stream<User?> get changes => _auth.authStateChanges();
  User? get user => _auth.currentUser;
  Future<User?> signIn(String e,String p)=>_auth.signInWithEmailAndPassword(email:e,password:p).then((c)=>c.user);
  Future<User?> signUp(String e,String p)=>_auth.createUserWithEmailAndPassword(email:e,password:p).then((c)=>c.user);
  Future<void> signOut()=>_auth.signOut();
}
