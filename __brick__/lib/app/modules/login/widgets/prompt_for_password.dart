import 'package:{{appName.snakeCase()}}/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class PromptForPassword extends HookWidget {
  const PromptForPassword({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Enter Password'),
            Text(
              'We found an existing account for $email. Please enter password to link with Google.',
            ),
            Input(
              controller: controller,
              label: 'Password',
              hint: 'Password',
              icon: Icons.password,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
              obscureText: true,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.back(result: controller.text);
                  },
                  child: Text('Confirm'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
