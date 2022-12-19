import 'package:educate_io/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class FirebaseAuthService {
  static Future<void> login(String email, String password) async {
    var instance = FirebaseAuth.instance;

    try {
      await instance.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> logOut() async {
    var instance = FirebaseAuth.instance;

    await instance.signOut();
    Get.appUpdate();
  }
}
