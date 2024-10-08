import 'package:ui/util/constants.dart';
import 'package:flutter/material.dart';


class LeaderboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LeaderboardAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(70);
 

  @override
  Widget build(BuildContext context) {
    
    return AppBar(
      // toolbarHeight: 250,
      automaticallyImplyLeading: false,
      backgroundColor: Constants.primaryColor,
      elevation: 2.0,
      title: Column(
        children: [
          bigTitle('Leaderboard'),
        ],
      ),
    );
  }

  leagues() {
    ScrollController _controller =
        ScrollController(initialScrollOffset: 89.8 * 4.4);

    return SizedBox(
      height: 100,
      child: ListView(
        // itemExtent: 80,
        controller: _controller,
        // shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          Image.asset('assets/images/badge_bronze_blank.png'),
          Image.asset('assets/images/badge_silver_blank.png'),
          Image.asset('assets/images/badge_gold_blank.png'),
          Image.asset('assets/images/badge_diamond_blank.png'),
          Image.asset('assets/images/badge_ruby_blank.png'),
          Image.asset('assets/images/badge_emerald_blank.png'),
          Container(
            margin: const EdgeInsets.only(left: 12, right: 8),
            child: Image.asset('assets/images/badge_amethyst.png', scale: 0.5),
          ),
          Image.asset('assets/images/badge_locked.png'),
          Image.asset('assets/images/badge_locked.png'),
          Image.asset('assets/images/badge_locked.png'),
        ],
      ),
    );
  }

  remainingDay(text) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Color(0xFFFFC800),
        ),
      ),
    );
  }

  message(text) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          color: Color(0xFFAFAFAF),
        ),
      ),
    );
  }

  bigTitle(text) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
