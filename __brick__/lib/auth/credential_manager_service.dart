import 'dart:developer';

import 'package:credential_manager/credential_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CredentialManagerService extends GetxService {
  final CredentialManager credentialManager = CredentialManager();

  @override
  void onInit() async {
    super.onInit();
    if (credentialManager.isSupportedPlatform) {
      await credentialManager.init(
        preferImmediatelyAvailableCredentials: true,
        googleClientId:
            '302303927717-i4sf3s6rtisjvk2amese2hss08v8i6il.apps.googleusercontent.com',
      );
    }
  }

  Future<OAuthCredential?> signInWithGoogle() async {
    try {
      final GoogleIdTokenCredential? credential = await credentialManager
          .saveGoogleCredential(useButtonFlow: false);

      if (credential == null) return null;

      final googleAuthCredential = GoogleAuthProvider.credential(
        idToken: credential.idToken,
      );

      return googleAuthCredential;
    } catch (e) {
      log('Google Sign-In failed: $e');
      return null;
    }
  }
}
