import 'package:{{appName}}/auth/auth.controller.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final authController = Get.find<AuthController>();

  void signOut() {
    authController.signOut();
  }
}
