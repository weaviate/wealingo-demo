
import 'package:flutter/material.dart';

class BottomNavigator extends StatelessWidget {
  final Function(int) onPress;
  final int currentIndex;

  const BottomNavigator({required this.currentIndex, required this.onPress, Key? key,

    })
      : super(key: key);


  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      showSelectedLabels: false,
      // enableFeedback: false,
      // showUnselectedLabels: false,
      // unselectedItemColor: Colors.grey,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/home_off.png',
            height: 40,
          ),
          activeIcon: Image.asset(
            'assets/icons/home_green.png',
            height: 40,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/tutor_off.png',
            height: 40,
          ),
          activeIcon: Image.asset(
            'assets/icons/tutor_on.png',
            height: 40,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/leaderboard_off.png',
            // color: Colors.grey,
            height: 40,
          ),
          activeIcon: Image.asset(
            'assets/icons/leaderboard_on.png',
            height: 40,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/quiz_off.png',
            height: 40,
          ),
          activeIcon: Image.asset(
            'assets/icons/quiz_on.png',
            height: 40,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/search_off.png',
            height: 40,
          ),
          activeIcon: Image.asset(
            'assets/icons/search_on.png',
            height: 40,
          ),
          label: '',
        ),
      ],
      currentIndex: currentIndex,
      // selectedItemColor: Colors.blue,
      onTap: onPress,
    );
  }

}
