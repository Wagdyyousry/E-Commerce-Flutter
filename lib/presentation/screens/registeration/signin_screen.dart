import 'package:ecommerce/presentation/widgets/common/custom_divider.dart';
import 'package:ecommerce/presentation/widgets/common/header_with_image.dart';
import 'package:ecommerce/presentation/widgets/registeration/signin_form.dart';
import 'package:ecommerce/presentation/widgets/registeration/social_buttons.dart';
import 'package:ecommerce/utils/constants/my_images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(SignInController());
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            children: [
              // -- Logo & Title & SubTitle
              SizedBox(height: MySizes.spaceBtwSections),
              HeaderWithImage(
                logo: MyImages.logo2,
                title: MyTexts.loginTitle,
                subtitle: MyTexts.loginSubTitle,
              ),

              // -- Form fields
              SignInForm(),

              // -- Devider
              CustomDivider(centertitle: MyTexts.orSignInwith),
              SizedBox(height: MySizes.spaceBtwSections),

              // -- Footer & Other Registeration Methods
              SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
