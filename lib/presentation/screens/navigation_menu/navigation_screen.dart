import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerce/data/controllers/database_controller.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import '../../../data/controllers/home/details_controller.dart';
import '../../../data/controllers/home/products_controller.dart';
import '../../../data/controllers/home/screen_nav_controller.dart';
import '../../../data/controllers/home/user_controller.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  late final ScreenNavController mainNavController;
  late final UserController userController;
  late final ProductsController productsController;
  late final DetailsController detailsController;
  late final DatabaseController databaseController;

  @override
  void initState() {
    super.initState();
    initializeAllControllers();
    getDataAgain();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => CurvedNavigationBar(
          height: 50,
          color: Colors.blue,
          animationDuration: const Duration(milliseconds: 700),
          backgroundColor: Colors.white,
          items: const [
            Icon(Iconsax.home, color: Colors.white),
            Icon(Iconsax.shop, color: Colors.white),
            Icon(Iconsax.heart, color: Colors.white),
            Icon(Iconsax.user, color: Colors.white),
          ],
          index: mainNavController.selectedScreenIndex.value,
          onTap: (index) => mainNavController.selectedScreenIndex.value = index,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => await getDataAgain(),
        child: Obx(() => mainNavController
            .screens[mainNavController.selectedScreenIndex.value]),
      ),
    );
  }

  void initializeAllControllers() {
    mainNavController = Get.put(ScreenNavController());
    userController = Get.put(UserController());
    productsController = Get.put(ProductsController());
    detailsController = Get.put(DetailsController());
    databaseController = Get.put(DatabaseController());
  }

  Future<void> getDataAgain() async {
    await productsController.getAllBrands();
    await productsController.getAllProducts();
    await productsController.getBestOfferProducts();
    await userController.getCurrentUserData();
    await userController.getAllUsers();
  }
}


// -- New Nav bar2
/* floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        onPressed: () => Get.to(() => const CartScreen()),
        child: const Icon(Icons.shopping_cart_outlined, color: Colors.blue),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:Obx(
        () => AnimatedBottomNavigationBar(
          icons: const [
            Iconsax.home,
            Iconsax.shop,
            Iconsax.heart,
            Iconsax.user,
          ],
          notchMargin: 15,
          backgroundGradient: MyColors.blueGradientLight,
          activeColor: Colors.blue,
          inactiveColor: Colors.white,
          activeIndex: mainNavController.selectedScreenIndex.value,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.smoothEdge,
          leftCornerRadius: 25,
          rightCornerRadius: 25,
          onTap: (index) => mainNavController.selectedScreenIndex.value = index,
          //other params
        ),
      ), */

// -- Old nav bar
 /* Obx(
        () => NavigationBar(
          height: 80,
          selectedIndex: mainNavController.selectedScreenIndex.value,
          onDestinationSelected: (index) =>
              mainNavController.selectedScreenIndex.value = index,
          backgroundColor: isDark ? MyColors.black : MyColors.textWhite,
          indicatorColor: isDark
              ? MyColors.textWhite.withOpacity(0.1)
              : MyColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
            NavigationDestination(icon: Icon(Iconsax.shop), label: "Shop"),
            NavigationDestination(
                icon: Icon(Iconsax.heart), label: "Favorites"),
            NavigationDestination(icon: Icon(Iconsax.user), label: "Setting"),
          ],
        ),
      ), */


