import 'package:{{appName.snakeCase()}}/auth/auth.controller.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardController extends GetxController {
  final authController = Get.find<AuthController>();
  User? get user => authController.currentUser;
  String? photo() {
    return authController.currentUser?.photoURL;
  }

  String? displayName() {
    return authController.currentUser?.displayName;
  }
}
