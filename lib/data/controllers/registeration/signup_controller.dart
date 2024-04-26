import 'package:ecommerce/data/repository/registration_repo.dart';
import 'package:ecommerce/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/loaders/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  // -- variables
  final FirebaseAuth mAuth = FirebaseAuth.instance;
  late final FirebaseFirestore mFirestore;
  late RegisterationRepo myRepo;

  // -- Variables for input fields
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;

  @override
  void onInit() {
    super.onInit();
    myRepo = RegisterationRepo();
    mFirestore = FirebaseFirestore.instance;
  }

  // -- Sign Up Method
  Future<void> signUp() async {
    try {
      // -- Check Form Validation
      if (!formKey.currentState!.validate()) return;

      // -- check privacy policy
      if (!privacyPolicy.value) {
        MyLoaders.warningSnackBar(
          title: MyTexts.acceptPrivacy,
          message: MyTexts.acceptPrivacyCon,
        );
        return;
      }

      // -- Create New User
      await createNewUser();
    } catch (e) {
      MyLoaders.errorSnackBar(title: "Error : ", message: e.toString());
    }
  }

  Future<void> createNewUser() async {
    UserModel user = UserModel(
      name: "${firstName.text} ${lastName.text}",
      email: email.text,
      password: password.text,
      phoneNumber: phoneNumber.text,
      userId: "",
    );

    await myRepo.createNewUser(user);
  }
}




/* import 'package:ecommerce/data/models/user_model.dart';
import 'package:ecommerce/presentation/screens/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/exeption/firebase_exeptions.dart';
import 'package:ecommerce/utils/loaders/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  late final FirebaseAuth mAuth;
  late final FirebaseFirestore mFirestore;

  @override
  void onInit() {
    super.onInit();
    mAuth = FirebaseAuth.instance;
    mFirestore = FirebaseFirestore.instance;
  }

  // -- Variables
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;

  // -- Sign Up Method
  Future<void> signUp() async {
    try {
      // -- Check Form Validation
      if (!formKey.currentState!.validate()) return;

      // -- check privacy policy
      if (!privacyPolicy.value) {
        MyLoaders.warningSnackBar(
          title: MyTexts.acceptPrivacy,
          message: MyTexts.acceptPrivacyCon,
        );
        return;
      }

      // -- Create New User
      await createNewUser();
    } catch (e) {
      MyLoaders.errorSnackBar(title: "Error : ", message: e.toString());
    }
  }

  Future<void> createNewUser() async {
    UserModel user = UserModel(
      name: "${firstName.text} ${lastName.text}",
      email: email.text,
      password: password.text,
      phoneNumber: phoneNumber.text,
      userId: mAuth.currentUser!.uid,
    );
    
    // -- Start Loading
    MyLoaders.openLoadingDialog("Wait a moment we Registering you ...");
    try {
      await mAuth
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text)
          .whenComplete(() async {
        await storeUserData();
      });
    } on FirebaseAuthException catch (e) {
      MyFirebaseException.firebaseAuthException(e);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> storeUserData() async {
    
    await mFirestore.collection("Users").doc(mAuth.currentUser!.uid).set({
      "name": "${firstName.text} ${lastName.text}",
      "email": email.text,
      "password": password.text,
      "phoneNumber": phoneNumber.text,
      "userId": mAuth.currentUser!.uid,
    }).whenComplete(() {
      Get.offAll(() => const HomeScreen());
      MyLoaders.successSnackBar(
          title: "Success", message: "User Created Succesfully");
    }).catchError((e) {
      MyLoaders.awesomeDialogError(e);
    });
  }
}
 */