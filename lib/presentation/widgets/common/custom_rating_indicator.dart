import 'package:ecommerce/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';

class CustomRatingIndicator extends StatelessWidget {
  const CustomRatingIndicator({
    super.key,
    required this.text,
    required this.value,
  });
  final double value;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Expanded(
          flex: 9,
          child: SizedBox(
            width: MyHelpers.getScreenWidth(context) * 0.8,
            child: LinearProgressIndicator(
              value: value,
              minHeight: 10,
              valueColor: const AlwaysStoppedAnimation(Colors.blue),
              backgroundColor: Colors.grey,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ],
    );
  }
}
