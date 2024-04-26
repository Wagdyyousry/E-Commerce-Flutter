import 'package:ecommerce/presentation/screens/navigation_menu/settings/sub_setting/add_address_screen.dart';
import 'package:ecommerce/presentation/widgets/common/custom_appbar.dart';
import 'package:ecommerce/presentation/widgets/common/custom_circular_container.dart';
import 'package:ecommerce/presentation/widgets/common/custom_rounded_container.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  int selectedAddressIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("My Addresses"),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(MySizes.defaultSpace),
        child: ListView.separated(
          itemCount: 5,
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            return CustomRoundedContainer(
              enableBorder: true,
              borderColor: Colors.grey.withOpacity(0.3),
              onTap: () => setState(() {
                selectedAddressIndex = index;
              }),
              padding: const EdgeInsets.all(MySizes.defaultSpace / 2),
              backgroundColor: selectedAddressIndex == index
                  ? Colors.lightBlue.withOpacity(0.6)
                  : Colors.grey.withOpacity(0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // -- User name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Wagdy Alsayed",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      if (selectedAddressIndex == index)
                        const CustomCircularContainer(
                          width: 25,
                          height: 25,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.check,
                            size: 15,
                            color: Colors.blue,
                          ),
                        ),
                    ],
                  ),
                  // -- phone number
                  Text("+20123456789",
                      style: Theme.of(context).textTheme.bodyLarge),

                  // -- Address
                  Text(
                      "135-lagona-NewYork city - DownTown Third bloc on the left side first tower 7th floor",
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddAddressScreen()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
