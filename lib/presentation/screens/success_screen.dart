import 'package:ecommerce/presentation/widgets/common/header_with_image.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.onPressed,
  });

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(MySizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: MySizes.spaceBtwSections),
            // -- Image & Title & SubTitle
            HeaderWithImage(
              logo: image,
              title: title,
              subtitle: subTitle,
            ),

            // -- Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => onPressed,
                child: const Text(MyTexts.contu),
              ),
            ),

            const SizedBox(height: MySizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
