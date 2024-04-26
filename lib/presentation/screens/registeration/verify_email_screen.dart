import 'package:ecommerce/data/controllers/registeration/verify_email_controller.dart';
import 'package:ecommerce/presentation/screens/registeration/signin_screen.dart';
import 'package:ecommerce/presentation/widgets/common/header_with_image.dart';
import 'package:ecommerce/utils/constants/my_images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});
  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => const SignInScreen()),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            children: [
              // -- Image & Title & SubTitle
              const HeaderWithImage(
                logo: MyImages.verifyEmail,
                title: MyTexts.confirmEmail,
                subtitle: MyTexts.confirmEmailSubTitle,
              ),
              const SizedBox(height: MySizes.spaceBtwItems),

              // -- User Email That Will be Verified
              Text(
                email ?? "",
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: MySizes.spaceBtwSections),

              // -- Continue button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.checkEmailVervicationStaus(),
                  child: const Text(MyTexts.contu),
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwItems),

              // -- Resend Code Again
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => controller.sendEmailVerification(),
                  child: const Text(MyTexts.resendEmail),
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
