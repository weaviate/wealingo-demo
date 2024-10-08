import 'package:ui/util/user_provider.dart';
import 'package:ui/views/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/util/constants.dart';

class StatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StatAppBar({Key? key}) : super(key: key);
  // final Provider  userProvider;

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    String? username;
    final userProvider = Provider.of<UserProvider>(context);
    try {
      final user = userProvider.user;     
      if(user != null) {
        username = user.username;
      } else {
        username = 'Guest';
      }
    } catch (e) {
      logger.finer(e);
    }

    return appBar(context, userProvider, username);
  }

  Widget appBar(context, userProvider, username) {
    return AppBar(
      toolbarHeight: 150,
      leadingWidth: 100,
      backgroundColor: Constants.primaryColor,
      // elevation: 1.5,
      leading: logout(context, userProvider, username),
      shape: RoundedRectangleBorder(
        // borderRadius: BorderRadius.circular(20),
        // side: BorderSide(color: Colors.blue, width: 2)        
      ),
      title: Row(
        children: [
          const Padding(padding: EdgeInsets.only(right: 20)),
          title(username),
        ],
      ),
      actions: [
        Icon(
          Icons.circle,
          color: Colors.white,
          size: 35,
        ),
        Padding(
          padding: EdgeInsets.only(right: 10),
        ),
      ],
    );
  }

  Widget title(username) {
    return Row(
      children: [
        // const Padding(
        //   padding: EdgeInsets.all(4),
        // ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Hey, $username!',
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }


  Widget logout(context, userProvider, username) {
    return GestureDetector(
      onTap: () {
        logger.info('tapped');
        userProvider.clearUser();
        Navigator.pushNamed(context, '/home');
      },
      child: Padding(
        padding: EdgeInsets.only(left: 20),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            username =='Guest'?'': 'Logout',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      )
    ); 
  }

}
