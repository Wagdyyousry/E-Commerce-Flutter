import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/controllers/home/details_controller.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../common/custom_listview.dart';
import '../../../common/custom_rounded_container.dart';

class ProductSizes extends StatelessWidget {
  const ProductSizes({super.key, required this.productSizes});
  final List<String> productSizes;

  @override
  Widget build(BuildContext context) {
    final controller = DetailsController.instance;
    return SizedBox(
      height: 28,
      child: CustomListView(
        scrollDirection: Axis.horizontal,
        itemCount: productSizes.length,
        separatorBuilder: (c, i) =>
            const SizedBox(width: MySizes.spaceBtwItems / 3),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => controller.selectedSizeIndex.value = index,
            child: Obx(
              () => CustomRoundedContainer(
                radius: 7,
                width: 50,
                height: 25,
                padding: const EdgeInsets.all(2),
                borderColor: controller.selectedSizeIndex.value == index
                    ? Colors.red
                    : Colors.grey,
                enableBorder:
                    controller.selectedSizeIndex.value == index ? true : false,
                child: Text(productSizes[index].toString()),
              ),
            ),
          );
        },
      ),
    );
  }
}
