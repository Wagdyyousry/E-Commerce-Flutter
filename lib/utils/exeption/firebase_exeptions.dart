import 'package:ecommerce/utils/loaders/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyFirebaseException {
  static firebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        MyLoaders.errorToast(message: "No user found for that email.");
        break;

      case 'wrong-password':
        MyLoaders.errorToast(message: "Wrong password for that user.");
        break;

      case 'invalid-credential':
        MyLoaders.errorToast(
            message: "Error : Email and password not matching .");
        break;

      case 'weak-password':
        MyLoaders.errorToast(message: 'The password is too weak.');
        break;

      case 'email-already-in-use':
        MyLoaders.errorToast(message: 'The email used by another account .');
        break;
      case 'invalid-email':
        MyLoaders.errorToast(
            message: 'Invalid email. Please enter a valid email.');
        break;

      case 'user-disabled':
        MyLoaders.errorToast(
            message:
                'This account has been disabled. Please contact support for assistance.');
        break;

      case 'invalid-verification-code':
        MyLoaders.errorToast(
            message: 'Invalid verification code. Please enter a valid code.');
        break;

      case 'invalid-verification-id':
        MyLoaders.errorToast(
            message:
                'Invalid verification ID. Please request a new verification code.');
        break;
      case 'quota-exceeded':
        MyLoaders.errorToast(
            message: 'Quota exceeded. Please try again later.');
        break;

      case 'provider-already-linked':
        MyLoaders.errorToast(
            message: 'The account is already linked with another provider.');
        break;

      case 'operation-not-allowed':
        MyLoaders.errorToast(
            message:
                'This operation is not allowed. Contact support for assistance.');
        break;

      case 'app-not-authorized':
        MyLoaders.errorToast(
            message:
                'The app is not authorized to use Firebase Authentication with the provided API key.');
        break;
      case 'captcha-check-failed':
        MyLoaders.errorToast(message: 'The reCAPTCHA response is invalid. Please try again.');
        break;
      case 'keychain-error':
        MyLoaders.errorToast(
            message:
                'A keychain error occurred. Please check the keychain and try again.');
        break;
      case 'internal-error':
        MyLoaders.errorToast(
            message:
                'An internal authentication error occurred. Please try again later.');
        break;
      default:
        MyLoaders.errorToast(message: e.message!);
        return;
    }
  }
}
