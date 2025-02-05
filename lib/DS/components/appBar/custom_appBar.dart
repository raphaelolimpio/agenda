import 'package:agenda/DS/components/menu/custom_menu.dart';
import 'package:flutter/material.dart';
import 'package:agenda/DS/shared/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Widget? leading;

  const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor = cyanColor,
    this.leading,
  });

  void _onMenuItemSelected(String value, BuildContext context) {
    switch (value) {
      case "profile":
        Navigator.pushNamed(context, "/profile");
        break;
      case "settings":
        Navigator.pushNamed(context, "/settings");
        break;
      case "logout":
        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: backgroundColor,
      leading: leading,
      actions: [
        CustomMenu(
            onItemSelected: (value) => _onMenuItemSelected(value, context)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
