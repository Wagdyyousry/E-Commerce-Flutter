import 'package:ecommerce/data/controllers/registeration/signin_controller.dart';
import 'package:ecommerce/utils/validators/validators.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(MySizes.defaultSpace),
        child: Form(
          key: controller.forgetPasswordFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -- Title And SubTitle
              Text(
                MyTexts.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: MySizes.spaceBtwItems),

              Text(
                MyTexts.forgetPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: MySizes.spaceBtwSections * 1.5),

              // -- Email that will be send to the link
              TextFormField(
                controller: controller.resetEmail,
                validator: (value) => MyValidators.validateEmail(value),
                decoration: const InputDecoration(
                  label: Text(MyTexts.email),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwSections),

              // -- Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.resetPassord(),
                  child: const Text(
                    MyTexts.submit,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
