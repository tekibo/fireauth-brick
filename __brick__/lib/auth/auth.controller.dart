import 'package:{{appName.snakeCase()}}/auth/credential_manager_service.dart';
import 'package:{{appName.snakeCase()}}/auth/error_handler.dart';
import 'package:{{appName.snakeCase()}}/app/modules/login/widgets/prompt_for_password.dart';
import 'package:{{appName.snakeCase()}}/app/routes/app_pages.dart';
{{^useCredMgr}}import 'package:{{appName.snakeCase()}}/auth/google_sign_in.dart';{{/useCredMgr}}
import 'package:{{appName.snakeCase()}}/auth/success_handler.dart';
import 'package:{{appName.snakeCase()}}/utils/utils.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CredentialManagerService credentialManager = Get.find();
  final googleAuth = Get.find<GoogleSignInService>();

  final isLoading = true.obs;

  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<void> checkEmailVerification() async {
    if (currentUser?.emailVerified == false) {
      Snackbar.show(
        title: 'Email Not Verified',
        message: 'Please verify your email before logging in.',
        type: SnackType.error,
      );
    }
  }

  // ----------------------------
  // Email/Password Registration
  // ----------------------------
  Future<bool> registerWithEmailPassword(String email, String password) async {
    try {
      final account = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await sendEmailVerification(account.user);
      return true;
    } on FirebaseAuthException catch (e) {
      ErrorHandler.handleError(e);
      return false;
    }
  }

  // ----------------------------
  // Email/Password Sign In
  // ----------------------------
  Future<bool> signInWithEmailPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await checkEmailVerification();
      return true;
    } on FirebaseAuthException catch (e) {
      ErrorHandler.handleError(e);
      return false;
    }
  }

  // ----------------------------
  // Google Sign In
  // ----------------------------

  {{^useCredMgr}}
  Future<bool> signInWithGoogle() async {
    if (googleAuth.supportsAuth) {
      final credential = await googleAuth.signInWithGoogleWithScopes();
      if (credential == null) return false;
      await _auth.signInWithCredential(credential);
      return true;
    }
    return false;
  }
  {{/useCredMgr}}

  {{#useCredMgr}}
  Future<bool> signInWithGoogle() async {
    try {
      final googleAuthCredential = await credentialManager.signInWithGoogle();
      if (googleAuthCredential == null) return false;
      await _auth.signInWithCredential(googleAuthCredential);
      return true;
    } on FirebaseAuthException catch (e) {
      ErrorHandler.handleError(e);
      return false;
    }
  }
  {{/useCredMgr}}
  
  // ----------------------------
  // Sign Out
  // ----------------------------
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Get.offAllNamed(Routes.LOGIN);
    } on FirebaseAuthException catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  // ----------------------------
  // Password Reset
  // ----------------------------
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      SuccessHandler.handleSuccess(SuccessType.passwordResetEmailSent);
    } on FirebaseAuthException catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  Future<void> confirmPasswordReset(String code, String newPassword) async {
    try {
      await _auth.confirmPasswordReset(code: code, newPassword: newPassword);
      SuccessHandler.handleSuccess(SuccessType.passwordResetConfirmed);
    } on FirebaseAuthException catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  // ----------------------------
  // Email Verification
  // ----------------------------
  Future<void> sendEmailVerification(User? user) async {
    try {
      await user?.sendEmailVerification();
      SuccessHandler.handleSuccess(SuccessType.emailVerificationSent);
    } on FirebaseAuthException catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  // ----------------------------
  // Handle Existing Account
  // ----------------------------
  Future<void> handleExistingAccount(FirebaseAuthException e) async {
    final pendingCred = e.credential;
    final email = e.email;

    if (pendingCred == null || email == null) return;

    final password = await Get.dialog<String>(PromptForPassword(email: email));
    if (password == null) return;

    try {
      final userCred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCred.user?.linkWithCredential(pendingCred);
    } on FirebaseAuthException catch (e) {
      ErrorHandler.handleError(e);
    }
  }
}
