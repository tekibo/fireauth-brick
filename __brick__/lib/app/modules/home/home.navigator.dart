import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:{{appName.snakeCase()}}/app/modules/home/views/dashboard_view.dart';
import 'package:{{appName.snakeCase()}}/app/modules/home/views/settings_view.dart';

class HomeNavController extends GetxController {
  final currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }
}

class HomeNavigator extends GetView<HomeNavController> {
  const HomeNavigator({super.key});

  final List<Widget> _pages = const [DashboardView(), SettingsView()];

  final List<BottomNavigationBarItem> _items = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        body: _pages[controller.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
          items: _items,
        ),
      );
    });
  }
}
