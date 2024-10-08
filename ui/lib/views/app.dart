import 'package:ui/views/leaderboard_screen/leaderboard_screen.dart';
import 'package:ui/views/login_screen/login_screen.dart';
import 'package:ui/views/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'home_screen/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

final Logger logger = Logger('Wealingo');

class Wealingo extends StatelessWidget {
  const Wealingo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/leaderboard': (context) => const LeaderboardScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Wealingo',
      theme: ThemeData(
        textTheme: GoogleFonts.plusJakartaSansTextTheme(), 
        primaryColor: Color.fromRGBO(19, 12, 73, 1),
        // primarySwatch: Colors.blue,
      ),
      // home: const WelcomeScreen(),
    );
  }
}