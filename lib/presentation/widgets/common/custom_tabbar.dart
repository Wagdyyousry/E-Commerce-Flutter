import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/device/device_utils.dart';
import 'package:ecommerce/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar({
    super.key,
    required this.tabs,
  });

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final isDark = MyHelpers.isDarkMode(context);
    return Material(
      color: isDark ? Colors.black : Colors.white,
      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelColor: isDark ? Colors.white : MyColors.primary,
        unselectedLabelColor: MyColors.darkGrey,
        indicatorColor: MyColors.primary,
        tabs: tabs,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(MyDeviceUtils.getAppBarHeight());
}
