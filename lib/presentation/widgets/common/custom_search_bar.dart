import 'package:ecommerce/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.onChanged,
    this.height = 50,
    this.hint,
  });
  final void Function(String)? onChanged;
  final double height;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MyHelpers.getScreenWidth(context) * 0.85,
      height: MyHelpers.getResponsiveHeight(height),
      child: SearchBar(
        onChanged: onChanged,
        hintText: hint,
        leading: const Icon(Icons.search),
        shape: const MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
      ),
    );

    // -- Custom search bar
    // Container(
    //   width: width,
    //   margin: const EdgeInsets.all(15),
    //   height: height,
    //   // -- decoration for the hole container
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(15),
    //   ),

    //   child: TextField(
    //     onChanged: onChanged,
    //     // -- decoration for the inner text Field
    //     decoration: const InputDecoration(
    //       prefixIconColor: Colors.black,
    //       prefixIcon: Icon(Icons.search),
    //       hintText: "Search for product",
    //       hintStyle: TextStyle(color: Colors.grey),
    //     ),
    //   ),
    // );
  }
}
