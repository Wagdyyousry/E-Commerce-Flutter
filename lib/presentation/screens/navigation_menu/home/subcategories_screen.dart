import 'package:ecommerce/presentation/screens/navigation_menu/shop/sub_shop/details_screen.dart';
import 'package:ecommerce/presentation/widgets/common/custom_listview.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../data/controllers/home/products_controller.dart';
import '../../../widgets/common/custom_rounded_container.dart';
import '../../../widgets/navigation_menu/home/product_card_horizontal.dart';
import '../../../../utils/constants/my_images.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helpers.dart';
import '../../../widgets/common/custom_appbar.dart';
import '../../../widgets/common/custom_header.dart';
import '../../../widgets/common/custom_rounded_image.dart';
import 'package:flutter/material.dart';

class SubCategoriesScreen extends StatefulWidget {
  const SubCategoriesScreen({super.key});

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final productController = ProductsController.instance;
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Sports"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(MySizes.defaultSpace / 2),
        child: Column(
          children: [
            // -- Banner
            CustomRoundedImage(
              width: MyHelpers.getScreenWidth(context) * .85,
              height: MyHelpers.getResponsiveHeight(180),
              image: MyImages.onBordingScreenImage5,
            ),
            const SizedBox(height: MySizes.spaceBtwSections / 2),

            // -- ############################################

            // -- Equipments Header
            const CustomHeader(
              title: "Sports Equipments",
              showTextButton: true,
            ),
            const SizedBox(height: MySizes.spaceBtwItems / 2),

            // -- Equipments List
            SizedBox(
              height: MyHelpers.getResponsiveHeight(125),
              child: Obx(
                () => CustomListView(
                  scrollDirection: Axis.horizontal,
                  itemCount: productController.menProductsList.length,
                  separatorBuilder: (c, i) => const SizedBox(width: 10),
                  itemBuilder: (c, i) {
                    return productController.allProductsList.isNotEmpty
                        ? ProductCardHorizontal(
                            onPressed: () => Get.to(() => DetailsScreen(
                                  productData:
                                      productController.menProductsList[i],
                                )),
                            productData: productController.menProductsList[i],
                          )
                        : CustomRoundedContainer(
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey,
                              highlightColor: Colors.white,
                              child: Container(
                                margin: const EdgeInsets.only(right: 15),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    width: MyHelpers.getScreenWidth(context) * .75,
                                    height: MyHelpers.getResponsiveHeight(125),
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          );
                  },
                ),
              ),
            ),
            const SizedBox(height: MySizes.spaceBtwSections * .7),

            // -- ############################################

            // -- Shoes Header
            const CustomHeader(
              title: "Sports Shoes",
              showTextButton: true,
            ),
            const SizedBox(height: MySizes.spaceBtwItems / 2),

            // -- Shoes List
            SizedBox(
              height: MyHelpers.getResponsiveHeight(125),
              child: Obx(
                () => CustomListView(
                  scrollDirection: Axis.horizontal,
                  itemCount: productController.menProductsList.length,
                  separatorBuilder: (c, i) => const SizedBox(width: 10),
                  itemBuilder: (c, i) {
                    return ProductCardHorizontal(
                      onPressed: () => Get.to(() => DetailsScreen(
                            productData: productController.menProductsList[i],
                          )),
                      productData: productController.menProductsList[i],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: MySizes.spaceBtwSections * .7),

            // -- ##########################################

            // -- Suits Header
            const CustomHeader(
              title: "Sports Suits",
              showTextButton: true,
            ),
            const SizedBox(height: MySizes.spaceBtwItems / 2),

            // -- Suits List
            SizedBox(
              height: MyHelpers.getResponsiveHeight(125),
              child: Obx(
                () => CustomListView(
                  scrollDirection: Axis.horizontal,
                  itemCount: productController.menProductsList.length,
                  separatorBuilder: (c, i) => const SizedBox(width: 10),
                  itemBuilder: (c, i) {
                    return ProductCardHorizontal(
                      onPressed: () => Get.to(() => DetailsScreen(
                            productData: productController.menProductsList[i],
                          )),
                      productData: productController.menProductsList[i],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: MySizes.spaceBtwSections * .7),
          ],
        ),
      ),
    );
  }
}
