import 'package:flutter/material.dart';

class CustomDropDownMenu extends StatelessWidget {
  const CustomDropDownMenu({
    super.key,
    required this.items,
    required this.hint,
    required this.onChanged,
    this.iconSize,
    this.smallText = false,
    this.selectedItems,
  });
  final void Function(String? value) onChanged;
  final String hint;
  final List<String> items;
  final List<String>? selectedItems;
  final double? iconSize;
  final bool smallText;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      style: smallText ? Theme.of(context).textTheme.labelSmall! : null,
      hint: Text(hint),
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.sort,
          size: iconSize,
        ),
      ),
      items: [
        for (var item in items)
          DropdownMenuItem(
            value: item,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item),
                if (selectedItems != null)
                  if (selectedItems!.contains(item))
                    const Icon(Icons.check, size: 16, color: Colors.blue),
              ],
            ),
          ),
      ],
    );
  }
}
