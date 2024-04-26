import 'dart:io';
import 'package:ecommerce/utils/constants/my_images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helpers.dart';
import 'package:ecommerce/utils/loaders/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/controllers/home/user_controller.dart';
import '../../../../widgets/common/custom_header.dart';
import '../../../../widgets/navigation_menu/settings/profile_image.dart';
import '../../../../widgets/navigation_menu/settings/profile_menu.dart';
import '../../../registeration/signin_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final UserController controller;
  String? currentUserID;
  // -- TextFields Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  final isNameEnabled = false.obs,
      isPasswordEnabled = false.obs,
      isPhoneNumEnabled = false.obs;
  late String newName, newPassword, newPhoneNum;
  late String currentName, currentPassword, currentPhoneNum;

  @override
  void initState() {
    super.initState();
    controller = UserController.instance;
    currentUserID = controller.userData.value.userId!;

    // -- Variables
    currentName = controller.userData.value.name!;
    currentPassword = controller.userData.value.password!;
    currentPhoneNum = controller.userData.value.phoneNumber!;
    // -- putDataInFields
    nameController.text = controller.userData.value.name!;
    passwordController.text = controller.userData.value.password!;
    phoneNumController.text = controller.userData.value.phoneNumber!;
  }

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          "My Profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: SizedBox(
            width: MyHelpers.getScreenWidth(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                // -- User Image
                ProfileImage(
                  image: controller.currentUserImage.value != ""
                      ? controller.currentUserImage.value
                      : MyImages.onBordingScreenImage5,
                  onPressed: () async => await pickImageFromGallery(),
                  isNetworkImage:
                      controller.currentUserImage.value != "" ? true : false,
                ),

                // -- Divider
                const SizedBox(height: MySizes.spaceBtwItems / 2),
                const Divider(thickness: 2),
                const SizedBox(height: MySizes.spaceBtwItems),

                // -- profile data
                const CustomHeader(title: "Profile Information"),
                const SizedBox(height: MySizes.spaceBtwItems / 2),

                ////----> [ information data ]

                // -- User Name
                Obx(
                  () => ProfileMenu(
                    title: "Name : ",
                    textController: nameController,
                    enabled: isNameEnabled.value ? true : false,
                    icon: isNameEnabled.value ? Icons.check : Icons.edit,
                    onPressed: () async {
                      newName = nameController.text;
                      if (isNameEnabled.value && newName != currentName) {
                        await controller.updateSingleField("name", newName);
                      }
                      isNameEnabled.value = !isNameEnabled.value;
                    },
                  ),
                ),
                const SizedBox(height: MySizes.spaceBtwItems),

                // -- User E-mail
                Obx(
                  () => ProfileMenu(
                    title: "E-Mail",
                    value: controller.userData.value.email!,
                    icon: Icons.copy,
                    isEditable: false,
                    onPressed: () =>
                        MyHelpers.copyText(controller.userData.value.email!),
                  ),
                ),

                // -- User Password
                Obx(
                  () => ProfileMenu(
                    title: "Password : ",
                    textController: passwordController,
                    enabled: isPasswordEnabled.value ? true : false,
                    icon: isPasswordEnabled.value ? Icons.check : Icons.edit,
                    onPressed: () async {
                      newPassword = passwordController.text;
                      if (isPasswordEnabled.value &&
                          newPassword != currentPassword) {
                        MyLoaders.warningDialogWithButton(
                          title: "Warning",
                          onPressed: () async {
                            await controller.updateUserPassword(newPassword);
                            Get.offAll(() => const SignInScreen());
                          },
                          message:
                              "When You change the Password you will be directed to the Login screen to SignIn Again",
                        );
                        await controller.updateSingleField("email", newName);
                      }
                      isPasswordEnabled.value = !isPasswordEnabled.value;
                    },
                  ),
                ),
                const SizedBox(height: MySizes.spaceBtwItems),

                // -- User Id
                Obx(
                  () => ProfileMenu(
                    title: "User-Id",
                    value: controller.userData.value.userId!,
                    icon: Icons.copy,
                    isEditable: false,
                    onPressed: () =>
                        MyHelpers.copyText(controller.userData.value.userId!),
                  ),
                ),
                const SizedBox(height: MySizes.spaceBtwItems),

                // -- User Number
                Obx(
                  () => ProfileMenu(
                    title: "Phone-Number : ",
                    textController: phoneNumController,
                    enabled: isPhoneNumEnabled.value ? true : false,
                    icon: isPhoneNumEnabled.value ? Icons.check : Icons.edit,
                    onPressed: () async {
                      newPhoneNum = phoneNumController.text;
                      if (isPhoneNumEnabled.value &&
                          newPhoneNum != currentPhoneNum) {
                        await controller.updateSingleField(
                            "phoneNumber", newPhoneNum);
                      }
                      isPhoneNumEnabled.value = !isPhoneNumEnabled.value;
                    },
                  ),
                ),

                // -- Divider
                const SizedBox(height: MySizes.spaceBtwItems),
                const Divider(thickness: 2),
                const SizedBox(height: MySizes.spaceBtwSections),

                // -- Delete Account
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => MyLoaders.warningDialogWithButton(
                      onPressed: () async {
                        FirebaseAuth.instance.currentUser!.delete();
                        Get.offAll(() => const SignInScreen());
                      },
                    ),
                    child: const Text(
                      "Delete Account",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(height: MySizes.spaceBtwSections),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickImageFromGallery() async {
    final croppedImage = await MyHelpers.pickImageFromGallery(true);

    controller.currentUserImage.value = croppedImage;
    controller.updateUserImage(File(croppedImage));
  }
}
