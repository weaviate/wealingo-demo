import 'package:ui/util/constants.dart';
import 'package:flutter/material.dart';

class QuizAppBar extends StatelessWidget implements PreferredSizeWidget {
  const QuizAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // toolbarHeight: 140,
      backgroundColor: Constants.primaryColor,
      elevation: 1.5,
      centerTitle: true,
      title: const Text(
        'Quiz',
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
