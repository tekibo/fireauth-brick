import 'package:{{appName}}/auth/auth.controller.dart';
import 'package:{{appName}}/auth/credential_manager_service.dart';
import 'package:{{appName}}/auth/google_sign_in.dart';
import 'package:{{appName}}/app/routes/app_pages.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:get/get.dart';
import 'package:{{appName}}/app/modules/login/login.controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();
  await Hive.openBox('storage');

  Get.put(CredentialManagerService(), permanent: true);
  Get.put(GoogleSignInService(), permanent: true);
  Get.put(AuthController(), permanent: true);
  Get.put(LoginController(), permanent: true);

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: Routes.HOME,
      getPages: AppPages.routes,
      theme: FlexThemeData.light(scheme: FlexScheme.blue),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.blue),
      themeMode: ThemeMode.system,
    ),
  );
}
