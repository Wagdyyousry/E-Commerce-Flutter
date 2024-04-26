import 'package:ecommerce/presentation/widgets/common/custom_divider.dart';
import 'package:ecommerce/presentation/widgets/common/header_with_image.dart';
import 'package:ecommerce/presentation/widgets/registeration/signup_form.dart';
import 'package:ecommerce/presentation/widgets/registeration/social_buttons.dart';
import 'package:ecommerce/utils/constants/my_images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 30),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            children: [
              // -- Logo & Title & SubTitle
              HeaderWithImage(
                logo: MyImages.logo1,
                title: MyTexts.signupTitle,
                subtitle: "",
              ),

              // -- Form fields
              SignUpForm(),

              // -- Devider
              CustomDivider(centertitle: MyTexts.orSignupwith),
              SizedBox(height: MySizes.spaceBtwSections),

              // -- Footer & Other Registeration Methods
              SocialButtons(),
              SizedBox(height: MySizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
