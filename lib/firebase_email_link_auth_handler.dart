import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

/// Visit https://firebase.google.com/docs/auth/flutter/email-link-auth
class EmailLinkAuthHandler extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final ActionCodeSettings settings;
  final Logger _logger = Logger("EmailLinkAuthHandler");
  bool _loginInProgress = false;

  bool get loginInProgress => _loginInProgress;

  EmailLinkAuthHandler({
    FirebaseAuth? firebaseAuth,
    required this.settings,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> login(String email) async {
    try {
      _loginInProgress = true;
      notifyListeners();

      await _firebaseAuth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: settings,
      );
    } catch (ex) {
      _logger.severe("Failed to send sign in link to email $email.", ex);
    } finally {
      _loginInProgress = false;
      notifyListeners();
    }
  }
}
