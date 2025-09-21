import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:{{appName.snakeCase()}}/app/modules/home/controllers/dashboard.controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          spacing: 16,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(controller.photo() ?? ""),
            ),
            Text(controller.displayName() ?? ""),
          ],
        ),
      ),
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Dashboard')],
        ),
      ),
    );
  }
}
