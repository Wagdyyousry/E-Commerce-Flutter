import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helpers.dart';
import '../../../common/custom_circular_icon.dart';

class AddProductBottomNav extends StatelessWidget {
  const AddProductBottomNav({
    super.key,
    required this.count,
    required this.onPlusPressed,
    required this.onMinusPressed,
  });
  final VoidCallback onPlusPressed, onMinusPressed;
  final String count;

  @override
  Widget build(BuildContext context) {
    final isDark = MyHelpers.isDarkMode(context);
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(
          horizontal: MySizes.defaultSpace / 3,
          vertical: MySizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: isDark ? MyColors.grey : MyColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // -- add or remove products
          CustomCircularIcon(
            width: 45,
            height: 45,
            onPressed: onMinusPressed,
            icon: Icons.remove,
            iconColor: Colors.white,
            backgroundColor: Colors.blueGrey,
          ),
          const SizedBox(width: MySizes.spaceBtwItems),

          // -- Product Count
          Text(count, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(width: MySizes.spaceBtwItems),

          // -- Add Button
          CustomCircularIcon(
            width: 45,
            height: 45,
            onPressed: onPlusPressed,
            icon: Icons.add,
            iconColor: Colors.white,
            backgroundColor: Colors.blue,
          ),
          const SizedBox(width: MySizes.spaceBtwItems),
        ],
      ),
    );
  }
}
