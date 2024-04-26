import 'package:ecommerce/presentation/screens/registeration/signin_screen.dart';
import 'package:ecommerce/presentation/screens/success_screen.dart';
import 'package:ecommerce/data/repository/registration_repo.dart';
import 'package:ecommerce/utils/constants/my_images.dart';
import 'package:ecommerce/utils/loaders/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'dart:async';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  // -- Variables
  late RegisterationRepo myRepo;
  late FirebaseAuth mAuth;

  @override
  onInit() async {
    super.onInit();
    // -- Variables declearation
    mAuth = FirebaseAuth.instance;
    myRepo = RegisterationRepo();

    // -- Calling Main Functions
    await sendEmailVerification();
    setTimerForAutoRedirect();
  }

  Future<void> sendEmailVerification() async {
    await mAuth.currentUser!.sendEmailVerification();

    // -- show snackBar
    MyLoaders.successSnackBar(
      title: "Email Sent, ",
      message: "Please check your inbox and verify your email.",
    );
  }

  void setTimerForAutoRedirect() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        await mAuth.currentUser!.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user!.emailVerified) {
          timer.cancel();
          Get.offAll(
            () => SuccessScreen(
              image: MyImages.onBordingScreenImage6,
              title: "Verified ,",
              subTitle: "Your email verified Successfully",
              onPressed: () => Get.offAll(() => const SignInScreen()),
            ),
          );
        }
      },
    );
  }

  void checkEmailVervicationStaus() {
    final user = mAuth.currentUser;

    if (user != null && user.emailVerified) {
      Get.to(
        () => SuccessScreen(
          image: MyImages.onBordingScreenImage6,
          title: "Verified ,",
          subTitle: "Your email verified Successfully",
          onPressed: () => Get.offAll(() => const SignInScreen()),
        ),
      );
    }
  }
}
