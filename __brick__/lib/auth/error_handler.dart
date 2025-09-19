import 'package:firebase_auth/firebase_auth.dart';
import 'package:{{appName}}/auth/auth.controller.dart';
import 'package:{{appName}}/utils/shared/helpers/snackbar.dart';
import 'package:get/get.dart';

class ErrorHandler {
  static void handleError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
        Snackbar.show(
          title: 'Login failed',
          message: 'Invalid credential. Did you sign up with google?',
          type: SnackType.error,
        );
        break;
      case 'invalid-verification-code':
        Snackbar.show(
          title: 'Login failed',
          message: 'Invalid verification code',
          type: SnackType.error,
        );
        break;
      case 'invalid-verification-id':
        Snackbar.show(
          title: 'Login failed',
          message: 'Invalid verification ID',
          type: SnackType.error,
        );
        break;
      case 'account-exists-with-different-credential':
        Get.find<AuthController>().handleExistingAccount(e);
        break;
      case 'weak-password':
        Snackbar.show(
          title: 'Registration failed',
          message: 'Password is too weak',
          type: SnackType.error,
        );
        break;
      case 'email-already-in-use':
        Snackbar.show(
          title: 'Email already in use',
          message:
              'You already have an account with this email. Login instead.',
          type: SnackType.error,
        );
        break;
      case 'invalid-email':
        Snackbar.show(
          title: 'Registration failed',
          message: 'Invalid email',
          type: SnackType.error,
        );
        break;
      case 'operation-not-allowed':
        Snackbar.show(
          title: 'Registration failed',
          message: 'Operation not allowed',
          type: SnackType.error,
        );
        break;
      case 'too-many-requests':
        Snackbar.show(
          title: 'Registration failed',
          message: 'Too many requests',
          type: SnackType.error,
        );
        break;
      case 'network-request-failed':
        Snackbar.show(
          title: 'Registration failed',
          message: 'Network request failed',
          type: SnackType.error,
        );
        break;
      case 'unknown':
        Snackbar.show(
          title: 'Registration failed',
          message: 'Unknown error',
          type: SnackType.error,
        );
        break;
    }
  }
}
