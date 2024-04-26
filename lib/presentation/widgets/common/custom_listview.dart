import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.mainAxisExtent = 265,
    this.scroll = true,
    this.scrollDirection = Axis.vertical,
    required this.separatorBuilder,
  });

  final int itemCount;
  final double? mainAxisExtent;
  final Axis scrollDirection;
  final bool scroll;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget Function(BuildContext context, int index) separatorBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: separatorBuilder,
      shrinkWrap: true,
      itemCount: itemCount,
      scrollDirection: scrollDirection,
      padding: EdgeInsets.zero,
      physics: scroll ? null : const NeverScrollableScrollPhysics(),
      itemBuilder: itemBuilder,
    );
  }
}
