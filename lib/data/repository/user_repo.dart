import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../presentation/screens/navigation_menu/navigation_screen.dart';
import '../../utils/loaders/loaders.dart';

class UserRepo {
  late String currentUserID;
  late FirebaseFirestore mFireStore;

  UserRepo() {
    mFireStore = FirebaseFirestore.instance;
    currentUserID = FirebaseAuth.instance.currentUser!.uid;
  }

  // -- Current User Data
  Future<UserModel> getCurrentUser() async {
    UserModel currentUserData = UserModel();
    final userDoc =
        await mFireStore.collection('Users').doc(currentUserID).get();
    if (userDoc.exists) {
      currentUserData = UserModel.fromMap(userDoc.data()!);
    }

    return currentUserData;
  }

  // -- All Users Data
  Future<List<UserModel>> getAllUsers() async {
    List<UserModel> userList = [];
    final querySnapshot = await mFireStore.collection('Users').get();
    final usersMapList = querySnapshot.docs;
    if (usersMapList.isNotEmpty) {
      userList =
          usersMapList.map((user) => UserModel.fromMap(user.data())).toList();
    }

    return userList;
  }

  // -- User Data
  Future updateSingleField(String key, String value) async {
    try {
      MyLoaders.openLoadingDialog();

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUserID)
          .update({
        key: value,
      }).then((value) {
        MyLoaders.stopLoading();
        Get.offAll(() => const NavigationScreen());
        MyLoaders.successSnackBar(
          title: "Success",
          message: "$key Updated successfully",
        );
      });
    } catch (e) {
      MyLoaders.errorSnackBar(title: "Error", message: e);
    }
  }

  // -- User Password
  Future updateUserPassword(String newPassword) async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      await user.updatePassword(newPassword).then(
        (value) async {
          await mFireStore
              .collection('Users')
              .doc(currentUserID)
              .update({"password": newPassword});
        },
      );

      MyLoaders.successSnackBar(message: 'Password updated successfully');
    } catch (e) {
      MyLoaders.errorSnackBar(
          message: 'Failed to update Password: $e', duration: 5);
    }
  }

  // -- User Image
  Future updateUserImage(File imageFile) async {
    try {
      MyLoaders.openLoadingDialog();
      final storageReference = FirebaseStorage.instance
          .ref()
          .child("profile_images")
          .child(FirebaseAuth.instance.currentUser!.uid);
      await storageReference.putFile(imageFile);

      String url = await storageReference.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "profileImageUri": url,
      }).then((value) {
        MyLoaders.stopLoading();
        Get.offAll(() => const NavigationScreen());
        MyLoaders.successSnackBar(
          title: "Success",
          message: "Profile Image Updated successfully",
        );
      });
    } catch (e) {
      MyLoaders.errorSnackBar(title: "Error", message: e);
    }
  }

}
