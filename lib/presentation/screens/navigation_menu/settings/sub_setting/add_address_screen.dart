import 'package:ecommerce/data/controllers/home/add_address_controller.dart';
import 'package:ecommerce/presentation/widgets/common/custom_appbar.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddAddressController());
    return Scaffold(
      appBar:
          const CustomAppBar(title: Text("Add Address"), showBackArrow: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(MySizes.defaultSpace),
        child: Form(
          child: Column(
            children: [
              // -- Name
              TextFormField(
                controller: controller.name,
                validator: (name) => MyValidators.validateUserName(name),
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(MySizes.focusedBorderRadius)),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  prefixIcon: Icon(Icons.person),
                  labelText: MyTexts.name,
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwInputFields),

              // -- Phone Number
              TextFormField(
                validator: (value) => MyValidators.validatePhoneNumber(value),
                controller: controller.phoneNumber,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(MySizes.focusedBorderRadius)),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  prefixIcon: Icon(Icons.phone),
                  labelText: MyTexts.phoneNum,
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwInputFields),

              // -- Street & Postal-Code
              Row(
                children: [
                  // -- Street
                  Expanded(
                    child: TextFormField(
                      validator: (value) =>
                          MyValidators.validateEmpty(value, "Street"),
                      controller: controller.street,
                      expands: false,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(MySizes.focusedBorderRadius)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        labelText: "Street",
                      ),
                    ),
                  ),
                  const SizedBox(width: MySizes.spaceBtwItems),

                  // -- Postal Code
                  Expanded(
                    child: TextFormField(
                      validator: (value) =>
                          MyValidators.validateEmpty(value, "Postal Code"),
                      controller: controller.postalCode,
                      expands: false,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(MySizes.focusedBorderRadius)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        labelText: "Postal Code",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: MySizes.spaceBtwInputFields),

              // -- City & State
              Row(
                children: [
                  // -- City
                  Expanded(
                    child: TextFormField(
                      validator: (value) =>
                          MyValidators.validateEmpty(value, "City"),
                      controller: controller.city,
                      expands: false,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(MySizes.focusedBorderRadius)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        labelText: "City",
                      ),
                    ),
                  ),
                  const SizedBox(width: MySizes.spaceBtwItems),

                  // -- State
                  Expanded(
                    child: TextFormField(
                      validator: (value) =>
                          MyValidators.validateEmpty(value, "State"),
                      controller: controller.state,
                      expands: false,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(MySizes.focusedBorderRadius)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        labelText: "State",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: MySizes.spaceBtwInputFields),

              // -- Country
              TextFormField(
                controller: controller.country,
                validator: (value) =>
                    MyValidators.validateEmpty(value, "Country"),
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(MySizes.focusedBorderRadius)),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  prefixIcon: Icon(Iconsax.global),
                  labelText: "Country",
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwSections),

              // -- Add Address button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.addNewAddress(),
                  child: const Text("Save"),
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
