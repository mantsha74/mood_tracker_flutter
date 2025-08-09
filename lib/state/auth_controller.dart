import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/repo/auth_repo.dart';

class AuthController extends ChangeNotifier {
  final AuthRepo repo;
  User? user;
  AuthController(this.repo){ repo.changes.listen((u){ user=u; notifyListeners();}); }
  Future<void> signIn(String e,String p) async => repo.signIn(e,p);
  Future<void> signUp(String e,String p) async => repo.signUp(e,p);
  Future<void> signOut() async => repo.signOut();
}
