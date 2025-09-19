import 'package:get/get.dart';

class TextStyles {
  static buttonTextPrimary() =>
      Get.textTheme.bodyMedium?.copyWith(color: Get.theme.colorScheme.primary);
  static buttonTextOnPrimary() => Get.textTheme.bodyMedium?.copyWith(
    color: Get.theme.colorScheme.onPrimary,
  );
}
