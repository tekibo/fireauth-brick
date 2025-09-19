import 'package:firetest/utils/shared/helpers/helpers.dart';

enum SuccessType {
  emailVerificationSent,
  passwordResetEmailSent,
  passwordResetConfirmed,
}

class SuccessHandler {
  static void handleSuccess(SuccessType successType) {
    switch (successType) {
      case SuccessType.emailVerificationSent:
        Snackbar.show(
          title: 'Email verification sent',
          message: 'Please check your inbox',
        );
        break;
      case SuccessType.passwordResetEmailSent:
        Snackbar.show(
          title: 'Password reset email sent',
          message: 'Please check your inbox',
        );
        break;
      case SuccessType.passwordResetConfirmed:
        Snackbar.show(
          title: 'Password reset confirmed',
          message: 'Your password has been reset',
        );
        break;
    }
  }
}
