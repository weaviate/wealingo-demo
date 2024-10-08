import 'package:ui/util/constants.dart';
import 'package:flutter/material.dart';

class GenerativeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GenerativeScreenAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: ,
      toolbarHeight: 120,
      backgroundColor: Constants.primaryColor,
      elevation: 1.5,
      centerTitle: true,
      title: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Image.asset(
                'assets/icons/personal-tutor.png',
                height: 45,
                ),
          ),
          const Text(
            'Personal tutor',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 32),
          ),
        ],
      ),
    );
  }
}
