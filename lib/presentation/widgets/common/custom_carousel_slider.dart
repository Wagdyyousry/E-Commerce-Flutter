import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../data/controllers/home/home_controller.dart';
import '../../../data/controllers/home/products_controller.dart';
import '../../../utils/helpers/helpers.dart';
import '../../screens/navigation_menu/shop/sub_shop/details_screen.dart';
import 'custom_rounded_container.dart';
import 'custom_rounded_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'discount_badge.dart';

class CustomCarouselSlider extends StatelessWidget {
  const CustomCarouselSlider({
    super.key,
    this.onPressed,
    this.sliderHeight = 150,
  });

  final VoidCallback? onPressed;
  final double sliderHeight;

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    final productsController = ProductsController.instance;
    return Obx(
      () => productsController.bestOfferProductsList.isEmpty
          ? CustomRoundedContainer(
              child: Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.white,
                child: Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: MyHelpers.getScreenWidth(context) * 0.8,
                      height: MyHelpers.getResponsiveHeight(160),
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ):CarouselSlider.builder(
              itemCount: productsController.bestOfferProductsList.length,
              itemBuilder: (context, index, realIndex) {
                return InkWell(
                  onTap: () => Get.to(
                    () => DetailsScreen(
                      productData:
                          productsController.bestOfferProductsList[index],
                    ),
                  ),
                  child: CustomRoundedContainer(
                    enableBorder: true,
                    borderColor: Colors.grey,
                    child: Stack(
                      children: [
                        CustomRoundedImage(
                          enableBorder: false,
                          isNetworkImage: true,
                          image: productsController
                              .bestOfferProductsList[index].productImages![0],
                          width: double.infinity,
                          boxFit: BoxFit.fill,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: DiscountBadge(
                            discountPercentage: productsController
                                .bestOfferProductsList[index].productDiscount!,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                onPageChanged: (index, reason) =>
                    controller.updateBannersIndex(index),
                autoPlay: true,
                height: MyHelpers.getResponsiveHeight(sliderHeight),
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                viewportFraction: 0.8,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: const Duration(milliseconds: 500),
              ),
            )
          ,
    );
  }
}

