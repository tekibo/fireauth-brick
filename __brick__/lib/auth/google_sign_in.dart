import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService extends GetxService {
  final GoogleSignIn signIn = GoogleSignIn.instance;

  bool get supportsAuth => GoogleSignIn.instance.supportsAuthenticate();

  List<String> scopes = ['https://www.googleapis.com/auth/drive.file'];

  @override
  void onInit() {
    super.onInit();
    signIn.initialize(
      clientId: '{{googleClientId}}',
      serverClientId: '{{googleServerClientId}}',
    );
  }

  Future<OAuthCredential?> signInWithGoogle() async {
    final user = await signIn.authenticate();
    final googleAuthTokens = user.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuthTokens.idToken,
    );
    return credential;
  }

  Future<OAuthCredential?> signInWithGoogleWithScopes({
    bool isMandatory = true,
  }) async {
    final GoogleSignInAccount user = await signIn.authenticate();
    try {
      await user.authorizationClient.authorizationForScopes(scopes);
      await user.authorizationClient.authorizeScopes(scopes);
      final googleAuthTokens = user.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuthTokens.idToken,
      );

      return credential;
    } catch (e) {
      if (e.toString().contains('Cancelled by user') || !isMandatory) {
        final googleAuthTokens = user.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuthTokens.idToken,
        );

        return credential;
      }
      log('Google Sign-In failed: $e');
      return null;
    }
  }
}
