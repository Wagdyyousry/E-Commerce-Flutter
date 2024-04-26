import 'package:ecommerce/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressController extends GetxController {
  static AddAddressController get instance => Get.find();

  // -- Variables for input fields
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
 

  

  // -- Add New Address
  Future<void> addNewAddress() async {
    try {
      // -- Check Form Validation
      if (!formKey.currentState!.validate()) return;

    } catch (e) {
      MyLoaders.errorSnackBar(title: "Error : ", message: e.toString());
    }
  }

 
}


