import 'package:firetest/app/modules/login/widgets/forgot_password.dart';
import 'package:firetest/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firetest/app/modules/login/login.controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final isSignUp = controller.isSignUp.value;
        return SafeAreaCenter(
          child: Col(
            outerPadding: 32,
            scrollable: true,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              Text(
                "Welcome to {{appName}}",
                style: Get.textTheme.titleLarge,
              ).paddingOnly(bottom: 24),
              Text(
                isSignUp ? "Register a new account" : "Login to your account",
                style: Get.textTheme.titleLarge,
              ).paddingOnly(bottom: 24),
              LoginForm(controller: controller, isSignUp: isSignUp),
            ],
          ),
        );
      }),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.controller,
    required this.isSignUp,
  });

  final LoginController controller;
  final bool isSignUp;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        spacing: 16,
        children: [
          // Email field
          Input(
            controller: controller.email,
            label: "Email",
            hint: "Email",
            icon: Icons.email,
            validator: controller.validateEmail,
          ),

          _passwordField(),

          if (isSignUp)
            // Confirm password field
            Input(
              controller: controller.confirmPassword,
              label: "Confirm Password",
              hint: "Confirm Password",
              icon: Icons.password,
              obscureText: true,
              validator: controller.validateConfirmPassword,
            ),

          // Login/Register Button
          Button(
            onPressed: isSignUp ? controller.onSignUp : controller.onSignIn,
            type: ButtonType.elevated,
            height: 50,
            borderRadius: 12,
            useWidthAnimation: false,
            loadingWidth: 100,
            loadingWidget: Text(
              isSignUp ? "Registering..." : "Logging in...",
              style: Get.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            child: Text(
              isSignUp ? "Register" : "Login",
              style: Get.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ).paddingOnly(top: 8),

          if (controller.authController.currentUser?.emailVerified == false)
            Column(
              spacing: 8,
              children: [
                Text(
                  "Please verify your email before logging in.",
                  style: Get.textTheme.bodyMedium?.copyWith(color: Colors.red),
                ),
                Button(
                  onPressed: () =>
                      controller.authController.sendEmailVerification(
                        controller.authController.currentUser,
                      ),
                  type: ButtonType.fancy,
                  height: 50,
                  buttonColor: Colors.red,
                  borderRadius: 12,
                  child: Text(
                    "Resend Email Verification",
                    style: Get.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ).paddingOnly(top: 8),

          _loginOrRegisterToggle().paddingOnly(top: 16),

          Divider(
            color: Get.theme.dividerColor.withAlpha(128),
          ).paddingOnly(top: 16, bottom: 16),

          _googleSignInButton(),
        ],
      ),
    );
  }

  Column _passwordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: 8,
      children: [
        Input(
          controller: controller.password,
          label: "Password",
          hint: "Password",
          icon: Icons.password,
          obscureText: true,
          validator: controller.validatePassword,
        ),
        if (!isSignUp)
          GestureDetector(
            onTap: () =>
                Get.bottomSheet(ForgotPassword(email: controller.email.text)),
            child: Text(
              'Forgot password?',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
      ],
    );
  }

  Row _loginOrRegisterToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 4,
      children: [
        Text(
          isSignUp ? "Already have an account?" : "Don't have an account?",
          style: Get.textTheme.bodyMedium,
        ),
        // Login/Register toggle button
        GestureDetector(
          onTap: controller.toggleSignUp,
          child: Text(
            isSignUp ? "Login" : "Register",
            style: Get.textTheme.bodyMedium?.copyWith(
              color: Get.theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  Button _googleSignInButton() {
    return Button(
      onPressed: controller.onSignInWithGoogle,
      type: ButtonType.fancy,
      height: 50,
      borderRadius: 12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(FontAwesomeIcons.google, color: Get.theme.colorScheme.primary),
          Text("Sign In With Google", style: Get.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
