import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/settings.controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Settings"),
            ElevatedButton(
              onPressed: () {
                controller.signOut();
              },
              child: Text("Sign Out"),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Settings view')],
        ),
      ),
    );
  }
}
