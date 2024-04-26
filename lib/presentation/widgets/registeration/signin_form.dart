import 'package:ecommerce/data/controllers/registeration/signin_controller.dart';
import 'package:ecommerce/presentation/screens/registeration/forget_password_screen.dart';
import 'package:ecommerce/presentation/screens/registeration/signup_screen.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());
    //print("==========| Height |=> ${MyHelpers.getScreenHeight(context)}");
    //print("==========| Width |=> ${MyHelpers.getScreenWidth(context)}");
    return Form(
      key: controller.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: MySizes.spaceBtwSections),
        child: Column(
          children: [
            // -- Email
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(MySizes.focusedBorderRadius)),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                prefixIcon: Icon(Icons.email),
                labelText: MyTexts.email,
              ),
            ),
            const SizedBox(height: MySizes.spaceBtwInputFields),

            // -- Password
            Obx(
              () => TextFormField(
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(MySizes.focusedBorderRadius),
                    ),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  prefixIcon: const Icon(Icons.password),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                  ),
                  labelText: MyTexts.password,
                ),
              ),
            ),
            const SizedBox(height: MySizes.spaceBtwInputFields / 3),

            // -- Forget password
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text(
                    "Forget password",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                  onPressed: () => Get.to(() => const ForgetPasswordScreen()),
                ),
              ],
            ),
            const SizedBox(height: MySizes.spaceBtwSections),

            // -- Sign in button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.signInWithEmailAndPassword(),
                child: const Text(MyTexts.signIn),
              ),
            ),
            const SizedBox(height: MySizes.spaceBtwItems),

            // -- Create New Acount button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignUpScreen()),
                child: const Text(MyTexts.createAccount),
              ),
            ),
            const SizedBox(height: MySizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
