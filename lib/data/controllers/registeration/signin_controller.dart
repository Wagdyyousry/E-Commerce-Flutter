import 'package:ecommerce/data/models/user_model.dart';
import 'package:ecommerce/data/repository/registration_repo.dart';
import 'package:ecommerce/presentation/screens/registeration/reset_password_screen.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/loaders/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();
  // -- Variables
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  final resetEmail = TextEditingController();
  final password = TextEditingController();
  final email = TextEditingController();

  final hidePassword = true.obs;
  late FirebaseAuth mAuth;
  late RegisterationRepo myRepo;

  @override
  onInit() {
    super.onInit();
    mAuth = FirebaseAuth.instance;
    myRepo = RegisterationRepo();
  }

  Future<void> signInWithEmailAndPassword() async {
    if (formKey.currentState!.validate()) {
      await myRepo.signIn(email: email.text, password: password.text);
    }
  }

  Future<void> signInWithGoogle() async {
    MyLoaders.openLoadingDialog();

    UserCredential? userCredential = await myRepo.signInUsingGoogle();

    if (userCredential != null) {
      UserModel userModel = UserModel(
        email: userCredential.user?.email,
        password: "",
        name: userCredential.user?.displayName,
        phoneNumber: userCredential.user?.phoneNumber,
        profileImageUri: userCredential.user?.photoURL,
        userId: userCredential.user?.uid,
      );
      await myRepo.storeUserData(userModel, MyTexts.google);
    }
  }

  Future<void> resetPassord() async {
    if (forgetPasswordFormKey.currentState!.validate()) {
      MyLoaders.openLoadingDialog();

      await myRepo.resetPassword(resetEmail.text);
      MyLoaders.stopLoading();
      MyLoaders.successSnackBar(
          title: "Success",
          message: "We have sent you a link to reset your password");
      Get.to(() => const ResetPasswordScreen());
    }
  }
}
