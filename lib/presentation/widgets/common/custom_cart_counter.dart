import 'package:flutter/material.dart';

class CustomCartCounter extends StatelessWidget {
  const CustomCartCounter({
    super.key,
    required this.onPressed,
    this.cartColor = Colors.white,
    this.showCartCounter = true,
    this.cartCounter = 0,
  });
  final bool showCartCounter;
  final Color cartColor;
  final VoidCallback onPressed;
  final int cartCounter;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.shopping_cart_outlined, color: cartColor),
        ),
        if (showCartCounter)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  "$cartCounter",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: Colors.white),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
