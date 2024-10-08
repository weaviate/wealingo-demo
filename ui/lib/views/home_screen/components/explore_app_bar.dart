import 'package:ui/util/constants.dart';
import 'package:flutter/material.dart';

class ExploreAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ExploreAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 120,
      backgroundColor: Constants.primaryColor,
      elevation: 1.5,
      leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 32,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      centerTitle: true,
      title: const Text(
        'Search ',
        style: TextStyle( fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
