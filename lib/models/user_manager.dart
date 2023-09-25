import 'package:buddy/helpers/firebase_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:buddy/models/user_app.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserManager extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserApp? appUser;

  bool get isLoggedIn => appUser != null;

  bool _loading = false;
  bool get loading => _loading;

  UserManager() {
    _loadCurrentUser();
  }

  Future<void> signIn(
      {required UserApp userApp,
      required Function onFail,
      required Function onSuccess}) async {
    loading = true;
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: userApp.email, password: userApp.password!);

      await _loadCurrentUser(firebaseUser: result.user);

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> signUp({
    required UserApp userApp,
    required Function onFail,
    required Function onSuccess,
  }) async {
    loading = true;
    try {
      final UserCredential credential =
          await _auth.createUserWithEmailAndPassword(
        email: userApp.email,
        password: userApp.password!,
      );
      if (credential.user == null) return;
      appUser = userApp;
      appUser?.id = credential.user!.uid;

      userApp = appUser!;
      await userApp.saveData();

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(e);
    }
    loading = false;
  }

  void signOut() {
    _auth.signOut();
    appUser = null;
    notifyListeners();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({User? firebaseUser}) async {
    final User? currentUser = firebaseUser ?? _auth.currentUser;
    if (currentUser != null) {
      final docUser =
          await firestore.collection('users').doc(currentUser.uid).get();
      appUser = UserApp.fromDocument(docUser);
      notifyListeners();
    }
  }
}
