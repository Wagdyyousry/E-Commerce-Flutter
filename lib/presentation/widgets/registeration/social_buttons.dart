import 'package:ecommerce/data/controllers/registeration/signin_controller.dart';
import 'package:ecommerce/presentation/widgets/common/custom_circular_image.dart';
import 'package:ecommerce/utils/constants/my_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // -- Google icon
        CustomCircularImage(
          width: 50,
          height: 50,
          isNetworkImage: false,
          image: MyImages.googleIcon,
          enableBorder: true,
          borderColor: Colors.grey,
          onPressed: () => controller.signInWithGoogle(),
        ),

        // -- FaceBook icon
        const CustomCircularImage(
          width: 50,
          height: 50,
          enableBorder: true,
          borderColor: Colors.grey,
          isNetworkImage: false,
          image: MyImages.facebookIcon,
        ),

        // -- Twitter icon
        const CustomCircularImage(
          width: 50,
          height: 50,
          enableBorder: true,
          borderColor: Colors.grey,
          isNetworkImage: false,
          image: MyImages.twitterIcon,
        ),
      ],
    );
  }
}
