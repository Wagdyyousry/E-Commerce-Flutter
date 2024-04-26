import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';

class CustomCircularContainer extends StatelessWidget {
  const CustomCircularContainer({
    super.key,
    this.width = 400,
    this.height = 400,
    this.radius = 500,
    this.padding = 0,
    this.margin = 0,
    this.child,
    this.borderColor = Colors.red,
    this.enableBorder = false,
    this.backgroundColor = MyColors.textWhite,
  });
  final double width, height, padding, radius, margin;
  final Widget? child;
  final Color? backgroundColor, borderColor;
  final bool enableBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyHelpers.getResponsiveHeight(height),
      height: MyHelpers.getResponsiveHeight(height),
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
        border: enableBorder ? Border.all(color: borderColor!) : null,
      ),
      child: child,
    );
  }
}
