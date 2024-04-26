import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';

class CustomRoundedContainer extends StatelessWidget {
  const CustomRoundedContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.onTap,
    this.enableBorder = false,
    this.radius = MySizes.cardRadiusLg,
    this.backgroundColor = Colors.white,
    this.borderColor = MyColors.grey,
  });

  final double? width, height, radius;
  final Widget? child;
  final bool enableBorder;
  final Color borderColor;
  final Color backgroundColor;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width != null
            ? width == height
                ? MyHelpers.getResponsiveHeight(height!)
                : MyHelpers.getResponsiveWidth(width!)
            : null,
        height: height != null ? MyHelpers.getResponsiveHeight(height!) : null,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius!),
          border: enableBorder ? Border.all(color: borderColor) : null,
        ),
        child: Center(child: child),
      ),
    );
  }
}
