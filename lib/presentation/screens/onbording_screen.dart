import 'package:ecommerce/data/controllers/onbording/onbording_controller.dart';
import 'package:ecommerce/presentation/widgets/onbording/onbording_indicator.dart';
import 'package:ecommerce/presentation/widgets/onbording/onbording_page.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/my_images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/device/device_utils.dart';
import 'package:ecommerce/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class OnbordingScreen extends StatelessWidget {
  const OnbordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBordingController());
    final isDark = MyHelpers.isDarkMode(context);
    return Scaffold(
      body: Stack(
        children: [
          // -- Skip button
          Positioned(
            top: MyDeviceUtils.getAppBarHeight(),
            right: MySizes.defaultSpace,
            child: TextButton(
              child: const Text("Skip"),
              onPressed: () => OnBordingController.instance.skipPage(),
            ),
          ),

          // -- Horizontal Page View
          Positioned(
            top: MyDeviceUtils.getAppBarHeight() + 25,
            width: MyHelpers.getScreenWidth(context),
            height: MyHelpers.getScreenHeight(context) * .7,
            child: PageView(
              controller: controller.pageController,
              onPageChanged: controller.updatePageIndicator,
              children: const [
                OnBordingPage(
                  image: MyImages.onBordingScreenImage1,
                  title: MyTexts.onBoardingTitle1,
                  subTitle: MyTexts.onBoardingSubTitle1,
                ),
                OnBordingPage(
                  image: MyImages.onBordingScreenImage2,
                  title: MyTexts.onBoardingTitle2,
                  subTitle: MyTexts.onBoardingSubTitle2,
                ),
                OnBordingPage(
                  image: MyImages.onBordingScreenImage3,
                  title: MyTexts.onBoardingTitle3,
                  subTitle: MyTexts.onBoardingSubTitle3,
                ),
              ],
            ),
          ),

          // -- Smooth page indicator
          const OnbordingIndicator(),

          // -- Next button
          Positioned(
            bottom: MyDeviceUtils.getBottomNavigationBarHeight(),
            right: MySizes.defaultSpace,
            child: ElevatedButton(
              onPressed: () => OnBordingController.instance.nextPage(),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: isDark ? MyColors.primary : MyColors.black,
              ),
              child: const Icon(Iconsax.arrow_right_1),
            ),
          ),
        ],
      ),
    );
  }
}
