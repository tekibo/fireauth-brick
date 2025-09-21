import 'package:{{appName.snakeCase()}}/app/routes/app_pages.dart';
import 'package:{{appName.snakeCase()}}/auth/auth.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMiddleware extends GetMiddleware {
  User? get currentUser => FirebaseAuth.instance.currentUser;
  AuthController? get authController => Get.find<AuthController>();

  @override
  RouteSettings? redirect(String? route) {
    currentUser?.reload();
    if (currentUser != null && currentUser?.emailVerified == true) {
      switch (route) {
        case Routes.LOGIN:
          return const RouteSettings(name: Routes.HOME);
        default:
          return super.redirect(route);
      }
    } else if (currentUser != null && !currentUser!.emailVerified) {
      return const RouteSettings(name: Routes.LOGIN);
    } else {
      return const RouteSettings(name: Routes.LOGIN);
    }
  }
}
