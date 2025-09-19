import 'package:firetest/auth/auth.controller.dart';
import 'package:firetest/utils/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class ForgotPassword extends HookWidget {
  const ForgotPassword({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = useTextEditingController(text: email);
    final authController = Get.find<AuthController>();

    void onForgotPassword({required String email}) async {
      if (email.isNotEmpty) {
        await authController.sendPasswordResetEmail(email);
      }
    }

    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 32),
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Form(
        key: formKey,
        child: Col(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: [
            colorBar(color: Get.theme.colorScheme.secondary),
            const SizedBox(height: 8),
            // Title
            Text(
              'Forgot Password?',
              style: Get.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            // Description
            Text(
              'Please enter your email to reset password.',
              style: Get.textTheme.bodyMedium?.copyWith(
                color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),

            // Email field
            Input(
              controller: emailController,
              label: 'Email',
              hint: 'Email',
              icon: Icons.email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(value)) {
                  return 'Invalid email address';
                }
                return null;
              },
            ),
            // Cancel and Confirm buttons
            Row(
              spacing: 16,
              children: [
                // Cancel button
                Flexible(
                  child: Button(
                    type: ButtonType.outlined,
                    buttonColor: Colors.grey.shade700,
                    borderRadius: 12,
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Cancel',
                      style: Get.textTheme.labelLarge?.copyWith(
                        color: Get.theme.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                  ),
                ),
                // Send reset link button
                Flexible(
                  flex: 2,
                  child: Button(
                    type: ButtonType.fancy,
                    buttonColor: Get.theme.buttonTheme.colorScheme!.secondary,
                    useWidthAnimation: false,
                    loadingWidth: 100,
                    loadingWidget: Text(
                      'Sending reset link...',
                      style: Get.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    borderRadius: 12,
                    onPressed: () =>
                        onForgotPassword(email: emailController.text),

                    child: Text(
                      'Send Reset Link',
                      style: Get.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ).marginOnly(bottom: 8, top: 24),
          ],
        ),
      ),
    );
  }
}
