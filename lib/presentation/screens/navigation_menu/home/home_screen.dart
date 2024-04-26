import 'package:ecommerce/data/controllers/database_controller.dart';
import '../../../../data/controllers/home/products_controller.dart';
import '../../../../data/controllers/home/user_controller.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/texts.dart';
import '../../../../utils/helpers/helpers.dart';
import '../../../widgets/common/custom_appbar.dart';
import '../../../widgets/common/custom_cart_counter.dart';
import '../../../widgets/common/custom_circular_container.dart';
import '../../../widgets/common/custom_gridview.dart';
import '../../../widgets/common/custom_header.dart';
import '../../../widgets/common/custom_rounded_container.dart';
import '../../../widgets/common/custom_search_bar.dart';
import '../../../widgets/navigation_menu/home/banners.dart';
import '../../../widgets/navigation_menu/home/categories_section.dart';
import '../../../widgets/navigation_menu/home/product_card_vertical.dart';
import '../shop/sub_shop/all_products_screen.dart';
import '../shop/sub_shop/cart_screen.dart';
import '../shop/sub_shop/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userController = UserController.instance;
    final productsController = ProductsController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.blue,
          child: Column(
            children: [
              // -- Top section of the screen
              SizedBox(
                height: MyHelpers.getResponsiveHeight(300),
                child: Stack(
                  children: [
                    //background Shape
                    Positioned(
                      top: -150,
                      right: -250,
                      child: CustomCircularContainer(
                        backgroundColor: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    Positioned(
                      top: 100,
                      right: -300,
                      child: CustomCircularContainer(
                          backgroundColor: Colors.white.withOpacity(0.1)),
                    ),

                    // -- Header section
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // -- Appbar
                        CustomAppBar(
                          // -- Title
                          title: Column(
                            children: [
                              // -- appbar title
                              Text(
                                MyTexts.homeAppbarTitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .apply(color: MyColors.grey),
                              ),

                              // -- appbar subtitle [ User Name ]
                              Obx(
                                () => Text(
                                  userController.userData.value.name != null
                                      ? userController.userData.value.name!
                                      : MyTexts.homeAppbarSubTitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .apply(color: MyColors.textWhite),
                                ),
                              ),
                            ],
                          ),

                          // -- Actions
                          actions: [
                            Obx(
                              () => CustomCartCounter(
                                cartCounter: DatabaseController
                                    .instance.allCartProducts.length,
                                onPressed: () =>
                                    Get.to(() => const CartScreen()),
                              ),
                            )
                          ],
                        ),

                        // -- Search Bar
                        CustomSearchBar(
                            onChanged: (text) {},
                            hint: "Search For Some products ..."),

                        // -- Categories header
                        const Padding(
                          padding: EdgeInsets.only(left: MySizes.defaultSpace),
                          child: CustomHeader(
                            title: "Popular Categories",
                            showTextButton: false,
                            textColor: Colors.white,
                          ),
                        ),

                        // -- Categories items
                        const GategoriesSection(),
                      ],
                    )
                  ],
                ),
              ),

              // -- Bottom section
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: MySizes.defaultSpace),

                      // -- Banners Section
                      const Banners(),

                      // -- popular products header
                      Padding(
                        padding: const EdgeInsets.only(
                          left: MySizes.defaultSpace,
                          right: MySizes.defaultSpace,
                        ),
                        child: CustomHeader(
                          title: "Popular products",
                          showTextButton: true,
                          onPressed: () => Get.to(
                            () => const AllProductScreen(),
                          ),
                        ),
                      ),

                      // -- GridView for popular products
                      Obx(
                        () => Container(
                          padding: const EdgeInsets.all(MySizes.defaultSpace),
                          width: double.infinity,
                          child: CustomGridView(
                            reverse: true,
                            itemCount: productsController
                                    .allProductsList.isNotEmpty
                                ? (productsController.allProductsList.length /
                                        3)
                                    .ceil()
                                : 4,
                            itemBuilder: (c, i) {
                              return productsController
                                      .allProductsList.isNotEmpty
                                  ? ProductCardVertical(
                                      productData:
                                          productsController.allProductsList[i],
                                      onPressed: () => Get.to(
                                        () => DetailsScreen(
                                          productData: productsController
                                              .allProductsList[i],
                                        ),
                                      ),
                                    )
                                  : CustomRoundedContainer(
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 15),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Container(
                                              width: 180,
                                              height: 220,
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

