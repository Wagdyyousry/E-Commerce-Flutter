import 'package:ecommerce/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    super.key,
    required this.title,
    this.onPressed,
    this.showTextButton = false,
    this.showActionButton = false,
    this.titleButton = "view all",
    this.textColor,
  });
  final VoidCallback? onPressed;
  final String title, titleButton;
  final Color? textColor;
  final bool showTextButton;
  final bool showActionButton;
  @override
  Widget build(BuildContext context) {
    final isDark = MyHelpers.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // -- title
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: textColor),
        ),

        // -- title Text button
        if (showTextButton)
          TextButton(
            onPressed: onPressed,
            child: Text(
              titleButton,
              style: Theme.of(context).textTheme.titleSmall!.apply(
                  color: textColor,
                  decoration: TextDecoration.underline,
                  decorationColor: isDark ? Colors.white : Colors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

        // -- title Icon button
        if (showActionButton)
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.arrow_forward_ios),
          ),
      ],
    );
  }
}
