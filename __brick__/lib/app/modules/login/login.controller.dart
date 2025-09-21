{{#useCredMgr}}import 'package:firebase_auth/firebase_auth.dart';{{/useCredMgr}}
import 'package:{{appName.snakeCase()}}/auth/auth.controller.dart';
import 'package:{{appName.snakeCase()}}/app/routes/app_pages.dart';
import 'package:{{appName.snakeCase()}}/auth/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final isSignUp = false.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();
  final googleAuth = Get.find<GoogleSignInService>();

  {{#useCredMgr}}
  @override
  void onInit() {
    super.onInit();
    if (FirebaseAuth.instance.currentUser == null) {
      authController.signInWithGoogle(useButtonFlow: false);
    }
  }
  {{/useCredMgr}}

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.onClose();
  }

  void toggleSignUp() {
    isSignUp.value = !isSignUp.value;
  }

  void onSignInWithGoogle() async {
    final success = await authController.signInWithGoogle();
    if (success) {
      Get.offAllNamed(Routes.HOME);
    }
  }

  void onSignUp() async {
    if (formKey.currentState!.validate()) {
      await authController.registerWithEmailPassword(email.text, password.text);
    }
  }

  void onSignIn() async {
    if (formKey.currentState!.validate()) {
      final success = await authController.signInWithEmailPassword(
        email.text,
        password.text,
      );
      if (success) {
        Get.offAllNamed(Routes.HOME);
      }
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != password.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
