import 'package:ui/views/course_screen/course_tree.dart';
import 'package:ui/views/explore_screen/explore_alert.dart';
import 'package:ui/views/explore_screen/explore_screen.dart';
import 'package:ui/views/generative_screen/components/generative_app_bar.dart';
import 'package:ui/views/generative_screen/generative_alert.dart';
import 'package:ui/views/generative_screen/generative_screen.dart';
import 'package:ui/views/home_screen/components/explore_app_bar.dart';
import 'package:ui/views/home_screen/components/generative_app_bar.dart';
import 'package:ui/views/home_screen/components/leaderboard_app_bar.dart';
import 'package:ui/views/home_screen/components/quiz_app_bar.dart';
import 'package:ui/views/home_screen/components/stat_app_bar.dart';
import 'package:ui/views/home_screen/components/bottom_navigator.dart';
import 'package:ui/views/leaderboard_screen/leaderboard_screen.dart';
import 'package:ui/views/quiz_screen/quiz_screen_levels.dart';
import 'package:flutter/material.dart';
import 'components/generative_app_bar.dart';
import 'components/profile_app_bar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    final screens = [
      CourseTree(),
      GenerativeAlertScreen(),
      LeaderboardScreen(),
      QuizScreenLevels(),
      ExploreAlertScreen(),
    ];

    final List<PreferredSizeWidget> appBars = [
      StatAppBar(),
      GenerativeAppBar(),
      LeaderboardAppBar(),
      QuizAppBar(),
      ExploreAppBar(),
    ];

    return Scaffold(
      appBar: appBars[currentIndex],
      bottomNavigationBar: BottomNavigator(currentIndex: currentIndex, onPress: onBottomNavigatorTapped),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/slide-bg-grain2.png"), // Path to your image
                fit: BoxFit.cover,
              ),
            ),
          ),
          screens[currentIndex],
        ],
      )
      );
  }

  void onBottomNavigatorTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }


}
