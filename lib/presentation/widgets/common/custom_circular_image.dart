import 'package:ecommerce/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCircularImage extends StatelessWidget {
  const CustomCircularImage({
    super.key,
    required this.image,
    this.height = 60,
    this.width = 60,
    this.padding = 0,
    this.onPressed,
    this.isNetworkImage = true,
    this.isSvg = false,
    this.boxFit = BoxFit.fill,
    this.enableBorder = true,
    this.borderColor = Colors.white,
  });
  final bool enableBorder, isNetworkImage, isSvg;
  final Color borderColor;
  final String? image;
  final double width, height, padding;
  final VoidCallback? onPressed;
  final BoxFit boxFit;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: MyHelpers.getResponsiveHeight(height),
        height: MyHelpers.getResponsiveHeight(height),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          border: enableBorder ? Border.all(color: borderColor) : null,
          borderRadius: BorderRadius.circular(height * 2),
        ),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child:  image!.isEmpty || image == null
              ? const Center(child: CircularProgressIndicator())
              :  ClipRRect(
                  borderRadius: BorderRadius.circular(height * 2),
                  child: isNetworkImage
                      ? Image.network(image!, fit: boxFit)
                      : isSvg
                          ? SvgPicture.asset(image!, fit: boxFit)
                          : Image.asset(image!, fit: boxFit),
                ),
        ),
      ),
    );
  }
}
