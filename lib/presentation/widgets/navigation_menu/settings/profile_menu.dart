import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.title,
    this.value = "",
    required this.icon,
    this.onPressed,
    this.textController,
    this.enabled = false,
    this.isEditable = true,
  });
  final String title, value;
  final VoidCallback? onPressed;
  final TextEditingController? textController;
  final IconData icon;
  final bool enabled, isEditable;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
          overflow: TextOverflow.ellipsis,
        ),
        Flexible(
          child: isEditable
              ? TextFormField(
                  controller: textController,
                  textAlign: TextAlign.center,
                  enabled: enabled,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                )
              : Text(
                  value,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
        ),
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
        )
      ],
    );
  }
}
