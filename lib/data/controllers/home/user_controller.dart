import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/models/user_model.dart';
import 'package:ecommerce/data/repository/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  // -- Firebase
  FirebaseFirestore? mFireStore;
  String? currentUserId;

  late UserRepo userRepo;
  final currentUserImage = "".obs;
  final userData = UserModel().obs;
  final userList = [].obs;

  @override
  onInit() {
    super.onInit();
    mFireStore = FirebaseFirestore.instance;
    FirebaseAuth.instance.currentUser != null
        ? currentUserId = FirebaseAuth.instance.currentUser!.uid
        : currentUserId = null;
    userRepo = UserRepo();

    // -- Getting Current Users Data
    getCurrentUserData();
    getAllUsers();
  }

  // -- User Data
  Future<void> updateSingleField(String key, String value) async {
    await userRepo.updateSingleField(key, value);
  }

  // -- User Data
  Future<void> updateUserPassword(String newPassword) async {
    await userRepo.updateUserPassword(newPassword);
  }

  // -- User Image
  Future<void> updateUserImage(File imageFile) async {
    await userRepo.updateUserImage(imageFile);
  }

  // -- User Data
  Future<void> getCurrentUserData() async {
    userData.value = await userRepo.getCurrentUser();
    if (userData.value.profileImageUri != null) {
      currentUserImage.value = userData.value.profileImageUri!;
    }
  }

  // -- All Users Data
  Future<void> getAllUsers() async {
    userList.value = await userRepo.getAllUsers();
  }
}
