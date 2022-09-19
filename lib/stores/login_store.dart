import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/data/sp_pref.dart';
import 'package:recipe_app/model/user_model.dart';
import 'package:recipe_app/utils/shared_pref_key.dart';

class LoginStore extends ChangeNotifier {
  String? email = 'kalyani@gmail.com', password = 'Qwerty123456';

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  ValueChanged<String>? showMessage;

  void toggleLoading(bool val) {
    isLoading = val;

    notifyListeners();
  }

  Future<bool> signInUsingEmailPassword() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (!formKey.currentState!.validate()) {
      return false;
    }
    formKey.currentState!.save();

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email ?? '',
        password: password ?? '',
      );
      user = userCredential.user;
      UserModel userModel = UserModel()
        ..uId = user?.uid
        ..name = user?.displayName
        ..email = user?.email;

      SharedPref()
          .save(SharedPrefKeys.SP_KEY_USER, json.encode(userModel).toString());
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showMessage?.call('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showMessage?.call('Wrong password provided.');
      }
      return false;
    }
  }
}
