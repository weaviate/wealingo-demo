import 'package:flutter/material.dart';

import 'components/center_display.dart';
import 'components/get_started_button.dart';
import 'components/log_in_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WelcomeScreenState();
  }
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          CenterDisplay(),
          // const Expanded(child: CenterDisplay()),
          bottomButtons(),
        ],
      )
    );
  }

  bottomButtons() {
    return Center(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GetStartedButton(context),
            LogInButton(context),
          ],
        ),
      ),
    );
  }
}
