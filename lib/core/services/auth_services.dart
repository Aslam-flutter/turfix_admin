import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:turfix_admin/model/auth_model.dart';
import 'package:turfix_admin/view/auth/login_screen.dart';
import 'package:turfix_admin/widgets/dialog_box.dart';

class AuthServices {
  Future<UserCredential?> registerUser(AuthModel authmodel) async {
    try {
      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: authmodel.email,
        password: authmodel.password,
      );
      return cred;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<UserCredential?> loginUser(
    AuthModel authmodel,
    BuildContext context,
  ) async {
    try {
      final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: authmodel.email,
        password: authmodel.password,
      );
      return cred;
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'invalid-credential':
          message = 'Incorrect email or password.';
          break;

        case 'user-not-found':
          message = 'No account found with this email.';
          break;

        case 'wrong-password':
          message = 'Incorrect password. Please try again.';
          break;

        case 'invalid-email':
          message = 'Please enter a valid email address.';
          break;

        case 'user-disabled':
          message = 'This account has been disabled.';
          break;

        case 'too-many-requests':
          message = 'Too many attempts. Please try again later.';
          break;

        case 'network-request-failed':
          message = 'Please check your internet connection.';
          break;

        default:
          message = 'Unable to sign in. Please try again.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<void> logOut(BuildContext context) async {
    AppDialogs.customAlertBox(
      context,
      title: 'Log Out',
      message: 'Are you sure about to log out',
      buttonText: 'Logout',
      onTap: () async {
        await FirebaseAuth.instance.signOut();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
        );
      },
    );
  }
}
