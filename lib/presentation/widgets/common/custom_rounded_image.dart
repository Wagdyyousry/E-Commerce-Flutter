import 'dart:io';

import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/helpers/helpers.dart';

class CustomRoundedImage extends StatelessWidget {
  const CustomRoundedImage({
    super.key,
    required this.image,
    this.borderColor = Colors.grey,
    this.enableBorder = true,
    this.isNetworkImage = false,
    this.isFileImage = false,
    this.onPressed,
    this.height,
    this.width,
    this.padding,
    this.isSvg = false,
    this.borderWidth = 1,
    this.borderRadius = MySizes.md,
    this.boxFit = BoxFit.cover,
  });

  final String? image;
  final double? width, height, padding;
  final double borderRadius, borderWidth;
  final Color borderColor;
  final bool enableBorder, isNetworkImage, isFileImage, isSvg;
  final VoidCallback? onPressed;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width != null
            ? width == height
                ? MyHelpers.getResponsiveHeight(height!)
                : MyHelpers.getResponsiveWidth(width!)
            : null,
        height: height != null ? MyHelpers.getResponsiveHeight(height!) : null,
        padding: padding != null ? EdgeInsets.all(padding!) : null,
        decoration: BoxDecoration(
          border: enableBorder
              ? Border.all(color: borderColor, width: borderWidth)
              : null,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: image!.isEmpty || image == null
              ? const Center(child: CircularProgressIndicator())
              : isSvg
                  ? SvgPicture.asset(image!, fit: boxFit)
                  : isNetworkImage
                      ? Image.network(image!, fit: boxFit)
                      : isFileImage
                          ? Image.file(File(image!), fit: boxFit)
                          : Image.asset(image!, fit: boxFit),
        ),
      ),
    );
  }
}
