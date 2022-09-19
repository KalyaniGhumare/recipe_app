import 'package:recipe_app/constant/export.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationStore extends ChangeNotifier {
  String? email, fName, lName, password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();
  ValueChanged<String>? showMessage;

  User? user;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void toggleLoading(bool val) {
    isLoading = val;

    notifyListeners();
  }

  Future<bool> signUpUser() async {
    if (!formKey.currentState!.validate()) {
      return false;
    }
    formKey.currentState!.save();

    toggleLoading(true);
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email ?? '',
        password: password ?? '',
      );
      if (userCredential.user != null) {
        user = userCredential.user;
        print('user ${user.toString()}');
        await user?.updateDisplayName('$fName $lName');
        await user?.reload();
        print('_auth.currentUser ${_auth.currentUser.toString()}');
        user = _auth.currentUser;
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showMessage?.call('The account already exists for that email.');
        print('The account already exists for that email.');
      }
      return false;
    } catch (e) {
      print('signUpUser e ${e.toString()}');
      return false;
    }
    return false;
    toggleLoading(false);
  }
}
