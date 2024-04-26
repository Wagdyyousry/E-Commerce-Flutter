import 'package:ecommerce/data/controllers/home/user_controller.dart';
import 'package:ecommerce/presentation/screens/display_image_screen.dart';
import 'package:ecommerce/presentation/screens/navigation_menu/settings/sub_setting/addresses_screen.dart';
import 'package:ecommerce/presentation/screens/navigation_menu/settings/sub_setting/profile_screen.dart';
import 'package:ecommerce/presentation/screens/navigation_menu/settings/sub_setting/upload_products_screen.dart';
import 'package:ecommerce/presentation/screens/navigation_menu/shop/sub_shop/cart_screen.dart';
import 'package:ecommerce/presentation/screens/registeration/signin_screen.dart';
import 'package:ecommerce/presentation/widgets/common/custom_appbar.dart';
import 'package:ecommerce/presentation/widgets/common/custom_circular_image.dart';
import 'package:ecommerce/presentation/widgets/common/custom_header.dart';
import 'package:ecommerce/presentation/widgets/navigation_menu/settings/settings_menu_tile.dart';
import 'package:ecommerce/utils/constants/my_images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/helpers/helpers.dart';
import 'package:ecommerce/utils/loaders/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'sub_setting/upload_brands_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: CustomAppBar(
        title: Text(
          "Account",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // -- User section
            SizedBox(
              height: MyHelpers.getResponsiveHeight(70),
              child: SizedBox(
                height: 55,
                child: ListTile(
                  // -- User image
                  leading: Obx(
                    () => CustomCircularImage(
                      height: 50,
                      width: 50,
                      isNetworkImage:
                          controller.userData.value.profileImageUri != null
                              ? true
                              : false,
                      onPressed: () {
                        if (controller.userData.value.profileImageUri != null) {
                          Get.to(() => DispalyImageScreen(
                                isNetwork: true,
                                image:
                                    controller.userData.value.profileImageUri!,
                              ));
                        }
                      },
                      image: controller.userData.value.profileImageUri != null
                          ? controller.userData.value.profileImageUri!
                          : MyImages.userImage,
                    ),
                  ),
                  // -- User name
                  title: Obx(
                    () => Text(
                      controller.userData.value.name != null
                          ? controller.userData.value.name!
                          : MyTexts.homeAppbarSubTitle,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .apply(color: Colors.white),
                    ),
                  ),

                  // -- User Email
                  subtitle: Text(
                    controller.userData.value.email != null
                        ? controller.userData.value.email!
                        : "example@gmail.com",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(color: Colors.white),
                  ),

                  // -- Edit Button
                  trailing: IconButton(
                    onPressed: () => Get.to(() => const ProfileScreen()),
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // -- Bottom section
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(MySizes.defaultSpace),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //// ---- Acount settings
                    const CustomHeader(title: "Account Setting"),
                    const SizedBox(height: MySizes.spaceBtwItems),

                    // -- Addresses
                    SettingsMenuTile(
                      onTap: () => Get.to(() => const AddressesScreen()),
                      icon: Icons.home_outlined,
                      title: 'My Addresses',
                      subTitle: 'Set shopping delivery address',
                    ),
                    // -- My Cart
                    SettingsMenuTile(
                      icon: Icons.shopping_cart_outlined,
                      title: 'My Cart',
                      onTap: () => Get.to(() => const CartScreen()),
                      subTitle: 'Add, remove products and move to checkout ',
                    ),
                    // -- My orders
                    const SettingsMenuTile(
                      icon: Icons.shopping_bag_outlined,
                      title: 'My Orders',
                      subTitle: 'In-progress and Completed Orders',
                    ),
                    // -- Bank account
                    const SettingsMenuTile(
                      icon: Iconsax.bank,
                      title: 'Bank Account',
                      subTitle: 'Withdraw balance to registered bank account',
                    ),
                    // -- My Coupones
                    const SettingsMenuTile(
                      icon: Icons.discount_outlined,
                      title: 'My Coupons',
                      subTitle: 'List of all the discounted coupons',
                    ),
                    //-- Notification
                    const SettingsMenuTile(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      subTitle: 'Set any kind of notification message',
                    ),
                    //-- Account Privacy
                    const SettingsMenuTile(
                      icon: Icons.privacy_tip_outlined,
                      title: 'Account Privacy',
                      subTitle: 'Manage data usage and connected accounts',
                    ),
                    const SizedBox(height: MySizes.spaceBtwSections),

                    ///// ----- App Settings
                    const CustomHeader(title: 'App Settings'),
                    const SizedBox(height: MySizes.spaceBtwItems),

                    // -- Uploading Brands
                    SettingsMenuTile(
                      icon: Icons.upload_file_outlined,
                      title: 'Add Brands',
                      subTitle: 'Upload Brands to your Collection',
                      onTap: () => Get.to(() => const UploadBrandsScreen()),
                    ),

                    // -- Uploading Products
                    SettingsMenuTile(
                      icon: Icons.upload_file_outlined,
                      title: 'Add Products',
                      subTitle: 'Upload Products to your Collection',
                      onTap: () => Get.to(() => const UploadProductsScreen()),
                    ),

                    // -- set up your location
                    SettingsMenuTile(
                      icon: Icons.location_on_outlined,
                      title: 'GeoLocation',
                      subTitle: 'Set recommendation based on your location',
                      trailing: Switch(value: false, onChanged: (value) {}),
                    ),
                    const SizedBox(height: MySizes.spaceBtwSections),

                    // -- LogOut button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Get.offAll(() => const SignInScreen());
                          MyLoaders.successSnackBar(
                              title: "Signed Out, hope to see you again");
                        },
                        child: const Text("Logout"),
                      ),
                    ),
                    const SizedBox(height: MySizes.spaceBtwSections * 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
