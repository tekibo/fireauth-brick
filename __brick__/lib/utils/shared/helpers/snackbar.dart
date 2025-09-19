import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

enum SnackType { success, error, warning, info }

class Snackbar {
  static void show({
    String? title,
    required String message,
    Color? backgroundColor,
    Color? borderColor,
    Color? iconColor,
    SnackType type = SnackType.info,
  }) {
    HapticFeedback.lightImpact();
    Get.closeAllSnackbars();

    switch (type) {
      case SnackType.success:
        Get.snackbar(
          title ?? 'Success!',
          message,
          backgroundColor: backgroundColor ?? Colors.green.withAlpha(128),
          borderRadius: 12,
          borderColor: borderColor ?? Colors.green.withAlpha(226),
          borderWidth: 1.5,
          icon: FaIcon(
            FontAwesomeIcons.circleCheck,
            color: iconColor ?? Colors.green,
          ).marginOnly(left: 12, right: 12),
          margin: const EdgeInsets.all(12),
          overlayBlur: 9,
        );
        break;
      case SnackType.error:
        Get.snackbar(
          title ?? 'Oops!',
          message,
          backgroundColor: backgroundColor ?? Colors.red.withAlpha(128),
          borderRadius: 12,
          borderColor: borderColor ?? Colors.red.withAlpha(226),
          borderWidth: 1.5,
          icon: FaIcon(
            FontAwesomeIcons.circleExclamation,
            color: iconColor ?? Colors.red,
          ).marginOnly(left: 12, right: 12),
          margin: const EdgeInsets.all(12),
          overlayBlur: 9,
        );
        break;
      case SnackType.warning:
        Get.snackbar(
          title ?? 'Warning!',
          message,
          backgroundColor: backgroundColor ?? Colors.orange.withAlpha(128),
          borderRadius: 12,
          borderColor: borderColor ?? Colors.orange.withAlpha(226),
          borderWidth: 1.5,
          icon: FaIcon(
            FontAwesomeIcons.triangleExclamation,
            color: iconColor ?? Colors.orange,
          ).marginOnly(left: 12, right: 12),
          margin: const EdgeInsets.all(12),
          overlayBlur: 9,
        );
        break;
      case SnackType.info:
        Get.snackbar(
          title ?? 'Info',
          message,
          backgroundColor:
              backgroundColor ?? Get.theme.colorScheme.primary.withAlpha(128),
          borderRadius: 12,
          borderColor:
              borderColor ?? Get.theme.colorScheme.primary.withAlpha(226),
          borderWidth: 1.5,
          icon: FaIcon(
            FontAwesomeIcons.circleInfo,
            color: iconColor ?? Get.theme.colorScheme.primary,
          ).marginOnly(left: 12, right: 12),
          margin: const EdgeInsets.all(12),
          overlayBlur: 9,
        );
        break;
    }
  }
}
