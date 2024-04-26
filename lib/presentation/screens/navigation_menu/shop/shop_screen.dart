import 'package:ecommerce/data/models/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/controllers/home/products_controller.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helpers.dart';
import '../../../widgets/common/custom_appbar.dart';
import '../../../widgets/common/custom_cart_counter.dart';
import '../../../widgets/common/custom_gridview.dart';
import '../../../widgets/common/custom_header.dart';
import '../../../widgets/common/custom_search_bar.dart';
import '../../../widgets/common/custom_tabbar.dart';
import '../../../widgets/navigation_menu/shop/brand_card.dart';
import '../../../widgets/navigation_menu/shop/category_tab.dart';
import 'sub_shop/all_brands_screen.dart';
import 'sub_shop/brand_products_screen.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  BrandModel? nike, zara;

  @override
  Widget build(BuildContext context) {
    final isDark = MyHelpers.isDarkMode(context);
    final brandController = ProductsController.instance;
    for (BrandModel brand in brandController.allBrandList) {
      if (brand.brandName! == "NIKE") {
        nike = brand;
      }
      if (brand.brandName! == "ZARA") {
        zara = brand;
      }
    }
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text(
            "Store",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            CustomCartCounter(
              onPressed: () {},
              showCartCounter: true,
              cartColor: Colors.black,
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                expandedHeight: 440,
                backgroundColor: isDark ? Colors.black : Colors.white,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(MySizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // -- Search Bar
                      CustomSearchBar(
                        onChanged: (text) {},
                        hint: "Search for a product",
                      ),
                      const SizedBox(height: MySizes.spaceBtwSections),

                      // -- Features Brands title
                      CustomHeader(
                        title: "Features Brands",
                        showTextButton: true,
                        onPressed: () => Get.to(() => const AllBrandsScreen()),
                      ),
                      const SizedBox(height: MySizes.spaceBtwItems),

                      // --  Popular Brands
                      CustomGridView(
                        itemCount: 4,
                        mainAxisExtent: 55,
                        itemBuilder: (context, index) {
                          return Obx(
                            () => BrandCard(
                              brand: brandController.allBrandList[index],
                              onPressed: () => Get.to(
                                () => BrandProductsScreen(
                                    brandModel:
                                        brandController.allBrandList[index]),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                bottom: const CustomTabBar(
                  tabs: [
                    Tab(child: Text("Clothes")),
                    Tab(child: Text("Sports")),
                    Tab(child: Text("Electronics")),
                    Tab(child: Text("Furniture")),
                    Tab(child: Text("Animal")),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              CategoryTab(brandZara: zara, brandNike: nike),
              CategoryTab(brandZara: zara, brandNike: nike),
              CategoryTab(brandZara: zara, brandNike: nike),
              CategoryTab(brandZara: zara, brandNike: nike),
              CategoryTab(brandZara: zara, brandNike: nike),
            ],
          ),
        ),
      ),
    );
  }
}
