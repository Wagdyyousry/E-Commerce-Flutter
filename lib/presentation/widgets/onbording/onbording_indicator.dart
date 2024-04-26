import 'package:ecommerce/data/controllers/onbording/onbording_controller.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/device/device_utils.dart';
import 'package:ecommerce/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnbordingIndicator extends StatelessWidget {
  const OnbordingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnBordingController.instance;
    final isDark = MyHelpers.isDarkMode(context);
    return Positioned(
      bottom: MyDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: MySizes.defaultSpace,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavClick,
        count: 3,
        effect: ExpandingDotsEffect(
          activeDotColor: isDark ? MyColors.light : MyColors.dark,
          dotHeight: 6,
        ),
      ),
    );
  }
}
