import 'package:ecommerce/data/controllers/registeration/signup_controller.dart';
import 'package:ecommerce/utils/validators/validators.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = MyHelpers.isDarkMode(context);
    final controller = Get.put(SignUpController());
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          // -- Name
          Row(
            children: [
              // -- First Name
              Expanded(
                child: TextFormField(
                  validator: (value) => MyValidators.validateUserName(value),
                  controller: controller.firstName,
                  expands: false,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(MySizes.focusedBorderRadius)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    prefixIcon: Icon(Iconsax.user),
                    labelText: MyTexts.firstName,
                  ),
                ),
              ),
              const SizedBox(width: MySizes.spaceBtwItems),

              // -- Last name
              Expanded(
                child: TextFormField(
                  validator: (value) => MyValidators.validateUserName(value),
                  controller: controller.lastName,
                  expands: false,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(MySizes.focusedBorderRadius)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    prefixIcon: Icon(Iconsax.user),
                    labelText: MyTexts.lastName,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: MySizes.spaceBtwInputFields),

          // -- Email
          TextFormField(
            controller: controller.email,
            validator: (email) => MyValidators.validateEmail(email),
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(MySizes.focusedBorderRadius)),
                borderSide: BorderSide(color: Colors.blue),
              ),
              prefixIcon: Icon(Icons.email),
              labelText: MyTexts.email,
            ),
          ),
          const SizedBox(height: MySizes.spaceBtwInputFields),

          // -- Phone Number
          TextFormField(
            validator: (value) => MyValidators.validatePhoneNumber(value),
            controller: controller.phoneNumber,
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(MySizes.focusedBorderRadius)),
                borderSide: BorderSide(color: Colors.blue),
              ),
              prefixIcon: Icon(Icons.phone),
              labelText: MyTexts.phoneNum,
            ),
          ),
          const SizedBox(height: MySizes.spaceBtwInputFields),

          // -- Password
          Obx(
            () => TextFormField(
              validator: (value) => MyValidators.validatePassword(value),
              obscureText: controller.hidePassword.value,
              controller: controller.password,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(MySizes.focusedBorderRadius)),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                prefixIcon: const Icon(Icons.password),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.hidePassword.value =
                        !controller.hidePassword.value;
                  },
                  icon: Icon(controller.hidePassword.value
                      ? Iconsax.eye_slash
                      : Iconsax.eye),
                ),
                labelText: MyTexts.password,
              ),
            ),
          ),
          const SizedBox(height: MySizes.spaceBtwItems),

          //-- Terms & Conditions CheckBox
          Row(
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: Obx(
                  () => Checkbox(
                    value: controller.privacyPolicy.value,
                    onChanged: (value) =>
                        controller.privacyPolicy.value = value!,
                  ),
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwItems),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: MyTexts.iAgreeTo,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: MyTexts.privacyPolicy,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color:
                                isDark ? MyColors.textWhite : MyColors.primary,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                isDark ? MyColors.textWhite : MyColors.primary,
                          ),
                    ),
                    TextSpan(
                      text: MyTexts.and,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: MyTexts.termsofuse,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color:
                                isDark ? MyColors.textWhite : MyColors.primary,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                isDark ? MyColors.textWhite : MyColors.primary,
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: MySizes.spaceBtwSections),

          // -- Sign Up button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signUp(),
              child: const Text(MyTexts.createAccount),
            ),
          ),
          const SizedBox(height: MySizes.spaceBtwSections),
        ],
      ),
    );
  }
}
