import 'package:ecommerce/presentation/screens/navigation_menu/navigation_screen.dart';
import 'package:ecommerce/presentation/screens/registeration/verify_email_screen.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/exeption/firebase_exeptions.dart';
import 'package:ecommerce/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/utils/loaders/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';

class RegisterationRepo extends GetxController {
  static RegisterationRepo get instance => Get.find();
  late final FirebaseAuth mAuth;
  late final FirebaseFirestore mFirestore;

  RegisterationRepo() {
    mAuth = FirebaseAuth.instance;
    mFirestore = FirebaseFirestore.instance;
  }

  Future<void> signIn({required String email, required String password}) async {
    //MyLoaders.openLoadingDialog("Wait We Signing you In");
    MyLoaders.openLoadingDialog();
    try {
      await mAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                Get.offAll(() => const NavigationScreen()),
                MyLoaders.successToast(message: "Welcom again my friend"),
              });
    } on FirebaseAuthException catch (e) {
      MyLoaders.stopLoading();
      MyFirebaseException.firebaseAuthException(e);
    } catch (e) {
      MyLoaders.stopLoading();
      MyLoaders.errorSnackBar(title: "Error , ", message: e.toString());
    }
  }

  Future<void> createNewUser(
    UserModel userData,
  ) async {
    // -- Start Loading
    // MyLoaders.openLoadingDialog("Wait a moment we Registering you ...");
    MyLoaders.openLoadingDialog();

    try {
      await mAuth
          .createUserWithEmailAndPassword(
        email: userData.email!,
        password: userData.password!,
      )
          .whenComplete(() async {
        await storeUserData(userData, MyTexts.emailAndPass);
      });
    } on FirebaseAuthException catch (e) {
      MyFirebaseException.firebaseAuthException(e);
    }
  }

  Future<UserCredential?> signInUsingGoogle() async {
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      return await mAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      MyFirebaseException.firebaseAuthException(e);
    }

    return null;
  }

  Future<void> storeUserData(UserModel userData, String typeOfSignIn) async {
    if (typeOfSignIn == MyTexts.google) {
      await mFirestore.collection("Users").doc(userData.userId).set({
        "name": userData.name,
        "email": userData.email,
        "password": userData.password,
        "phoneNumber": userData.phoneNumber,
        "userId": userData.userId,
        "profileImageUri": userData.profileImageUri,
      }).whenComplete(() {
        // -- go to Home Screen
        Get.offAll(() => const NavigationScreen());
        MyLoaders.successSnackBar(
            title: "Congratulation", message: "Account Created Succesfully");
      }).catchError((e) {
        MyLoaders.awesomeDialogError(e);
      });
    } else {
      userData.userId = mAuth.currentUser!.uid;
      await mFirestore.collection("Users").doc(userData.userId).set({
        "name": userData.name,
        "email": userData.email,
        "password": userData.password,
        "phoneNumber": userData.phoneNumber,
        "userId": userData.userId,
        "profileImageUri": userData.profileImageUri,
      }).whenComplete(() {
        // -- verify email first
        Get.to(() => const VerifyEmailScreen());
        MyLoaders.successSnackBar(
            title: "Congratulation",
            message:
                "Account Created Succesfully, now verify your email to continue");
      }).catchError((e) {
        MyLoaders.awesomeDialogError(e);
      });
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await mAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      MyFirebaseException.firebaseAuthException(e);
    }
  }
}
