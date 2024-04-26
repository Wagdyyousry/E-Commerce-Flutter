import '../../../../data/controllers/home/home_controller.dart';
import '../../../../data/controllers/home/products_controller.dart';
import '../../../../utils/constants/sizes.dart';
import '../../common/custom_carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Banners extends StatelessWidget {
  const Banners({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final productsController = ProductsController.instance;
    return Column(
      children: [
        // -- Banner Slider
        Column(
          children: [
            // -- Banners
            const CustomCarouselSlider(sliderHeight: 150),
            const SizedBox(height: MySizes.spaceBtwItems),

            // -- indicators
            Obx(
              () => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0;
                      i < productsController.bestOfferProductsList.length;
                      i++)
                    Container(
                      width: 20,
                      height: 4,
                      margin: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: controller.carouselCurrentIndex.value == i
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
