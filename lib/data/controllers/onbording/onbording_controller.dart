import 'package:ecommerce/presentation/screens/registeration/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBordingController extends GetxController {
  static OnBordingController get instance => Get.find();
  final pageController = PageController();
  final currentPageIndex = 0.obs;

  void updatePageIndicator(index) => currentPageIndex.value = index;

  void dotNavClick(index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  void skipPage() {
    Get.offAll(() => const SignInScreen());
  }

  void nextPage() {
    if (currentPageIndex.value == 2) {
      Get.offAll(() => const SignInScreen());
    } else {
      currentPageIndex.value += 1;
      pageController.jumpToPage(currentPageIndex.value);
    }
  }
}
