import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';

class CustomCircularIcon extends StatelessWidget {
  const CustomCircularIcon({
    super.key,
    required this.icon,
    this.width,
    this.height,
    this.size = MySizes.lg,
    this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.enableBorder = false,
    this.borderColor = Colors.grey,
  });
  final Color? iconColor, backgroundColor, borderColor;
  final double? width, height, size;
  final VoidCallback? onPressed;
  final IconData icon;
  final bool enableBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor != null
            ? backgroundColor!
            : MyHelpers.isDarkMode(context)
                ? MyColors.black.withOpacity(0.9)
                : MyColors.light.withOpacity(0.9),
        borderRadius: BorderRadius.circular(100),
        border: enableBorder ? Border.all(color: borderColor!) : null,
      ),
      child: Center(
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: iconColor, size: size,),
        ),
      ),
    );
  }
}
