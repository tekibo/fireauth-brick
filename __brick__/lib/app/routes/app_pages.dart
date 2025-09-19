import 'package:firetest/auth/auth.middleware.dart';
import 'package:firetest/app/modules/home/bindings/home.bindings.dart';
import 'package:firetest/app/modules/home/home.navigator.dart';
import 'package:firetest/app/modules/login/login.view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeNavigator(),
      binding: HomeBindings(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(name: _Paths.LOGIN, page: () => const LoginView()),
  ];
}
