import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';

class HeaderWithImage extends StatelessWidget {
  const HeaderWithImage({
    super.key,
    required this.logo,
    required this.title,
    required this.subtitle,
    this.imageWidth = 200,
    this.imageHeight = 150,
  });
  final String logo, title, subtitle;
  final double imageWidth, imageHeight;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // -- Header image
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image(
              width: MyHelpers.getResponsiveWidth(imageWidth),
              height: MyHelpers.getResponsiveHeight(imageHeight),
              fit: BoxFit.cover,
              image: AssetImage(logo),
            ),
          ),
        ),

        // -- Header Title
        const SizedBox(height: MySizes.spaceBtwItems),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),

        // -- Header SubTitle
        const SizedBox(height: MySizes.sm),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        // -- space after
        const SizedBox(height: MySizes.spaceBtwSections),
      ],
    );
  }
}
