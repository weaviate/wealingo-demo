import 'dart:math';

import 'package:ui/views/app.dart';
import 'package:ui/views/course_screen/components/course_popup.dart';
import 'package:ui/views/lesson_screen/lesson_screen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CourseNode extends StatelessWidget {
  final String name;
  String? image;
  Color? color;
  int? crown;
  double? percent;

  CourseNode(this.name,
      {this.image, this.color, this.crown, this.percent, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LessonScreen(category: name),
              ),
            );
          },
          child: node(),
        ),
        // const Padding(padding: EdgeInsets.all(5)),
        courseName(),
      ],
    );
  }

  node() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset(
              image ?? 'assets/images/resources.png',
              width: 112,
              height: 110,
              fit: BoxFit.contain,
              // alignment: Alignment.center,
            ),
          ],
        ),
      ],
    );
  }

  courseName() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 150.0, // Set the width constraint for the text
          ),
          child: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.center, // Center align the text
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 2, // Restrict to two lines
          ),
        ),
      ),
    );    
  }

}
