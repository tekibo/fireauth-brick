import 'package:{{appName}}/app/modules/home/controllers/dashboard.controller.dart';
import 'package:{{appName}}/app/modules/home/controllers/settings.controller.dart';
import 'package:{{appName}}/app/modules/home/home.navigator.dart';
import 'package:get/get.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeNavController(), fenix: true);
    Get.lazyPut(() => DashboardController(), fenix: true);
    Get.lazyPut(() => SettingsController(), fenix: true);
  }
}
