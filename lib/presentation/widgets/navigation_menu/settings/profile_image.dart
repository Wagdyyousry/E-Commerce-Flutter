import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/helpers/helpers.dart';
import '../../../screens/display_image_screen.dart';
import '../../common/custom_circular_container.dart';
import '../../common/custom_circular_image.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.image,
    this.onPressed,
    this.isNetworkImage = false,
    this.width=160,
    this.height=160,
  });

  final String image;
  final double width, height;
  final bool isNetworkImage;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final isDark = MyHelpers.isDarkMode(context);
    return CustomCircularContainer(
      width: 165,
      height: 165,
      child: Stack(
        children: [
          CustomCircularImage(
              height: 155,
              width: 155,
              onPressed: () => Get.to(() => DispalyImageScreen(image: image)),
              enableBorder: true,
              borderColor: Colors.grey,
              image: image,
              isNetworkImage: isNetworkImage,
            ),

          // -- Edit button
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
                color: isDark ? Colors.black : Colors.white,
              ),
              child: IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.add,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
