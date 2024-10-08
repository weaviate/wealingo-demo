import 'package:ui/util/constants.dart';
import 'package:flutter/material.dart';

class LoginAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LoginAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // shadowColor: Colors.transparent,
      backgroundColor: Constants.secondaryColor,
      title: Text(
        'Welcome!',        
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.close,
          // color: Colors.grey.shade600,
        ),
        onPressed: () {
          // Navigator.pop(context);
          Navigator.pushNamed(context, '/home');
        },
      ),
    );
  }

}