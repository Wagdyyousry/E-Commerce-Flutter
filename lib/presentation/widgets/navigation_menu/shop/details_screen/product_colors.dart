import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/controllers/home/details_controller.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helpers.dart';
import '../../../common/custom_circular_container.dart';

class ProductColors extends StatelessWidget {
  const ProductColors({super.key, required this.productColors});
  final List<String> productColors;

  @override
  Widget build(BuildContext context) {
    final controller = DetailsController.instance;
    return SizedBox(
      height: MyHelpers.getResponsiveHeight(25),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: productColors.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (c, i) =>
            const SizedBox(width: MySizes.spaceBtwItems / 3),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              controller.selectedColorIndex.value = index;
            },
            child: Obx(() {
              final isSelected = controller.selectedColorIndex.value == index;
              return CustomCircularContainer(
                width: 25,
                height: 25,
                backgroundColor:MyHelpers.getColor(productColors[index]),
                borderColor: isSelected ? Colors.red : Colors.grey,
                enableBorder: isSelected ? true : false,
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        size: 15,
                        color: Colors.white,
                      )
                    : null,
              );
            }),
          );
        },
      ),
    );
  }
}
