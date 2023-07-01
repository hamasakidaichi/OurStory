import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future<void> signIn() async {
    debugPrint('サービスクラス');

    const clientId =
        '438511184427-b8ss08lbu276kav0giqsu6i927mfk157.apps.googleusercontent.com';

    const scopes = [
      'profile',
      'email',
    ];

    final request = GoogleSignIn(clientId: clientId, scopes: scopes);
    final response = await request.signIn();
    final authn = await response?.authentication;
    final accessToken = authn?.accessToken;

    if (accessToken == null) {
      return;
    }

    final oAuthCredential = GoogleAuthProvider.credential(
      accessToken: accessToken,
    );
    await FirebaseAuth.instance.signInWithCredential(
      oAuthCredential,
    );
  }

  Future<void> singOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
