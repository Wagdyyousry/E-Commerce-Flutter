import 'package:ecommerce/data/controllers/registeration/signin_controller.dart';
import 'package:ecommerce/presentation/screens/registeration/signin_screen.dart';
import 'package:ecommerce/presentation/widgets/common/header_with_image.dart';
import 'package:ecommerce/utils/constants/my_images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            children: [
              // -- image & Title & SubTitle
              const HeaderWithImage(
                logo: MyImages.verifyEmail2,
                title: MyTexts.changeYourPasswordTitle,
                subtitle: MyTexts.changeYourPasswordSubTitle,
              ),

              // -- Done Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: ()=> Get.offAll(() => const SignInScreen()),
                  child: const Text(MyTexts.done),
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwItems),

              // -- Resend Email
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => controller.resetPassord(),
                  child: const Text(
                    MyTexts.resendEmail,
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
