import 'package:ui/views/app.dart';
import 'package:ui/views/course_screen/components/course_popup.dart';
import 'package:ui/views/lesson_screen/lesson_screen.dart';
import 'package:ui/views/quiz_screen/components/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class QuizNode extends StatelessWidget {
  final String name;
  String? image;
  Color? color;
  final int level;
  double? percent;

  QuizNode(this.name,
      {this.image, this.color, required this.level, this.percent, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>  QuizScreen(level: level),
              ),
            );
          },
          child: node(),
        ),
      ],
    );
  }

  node() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        width: 450, 
        padding: EdgeInsets.all(20),  
        margin: EdgeInsets.all(5),      
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Image.asset(
                image ?? 'assets/images/egg.png',
                width: 100,
              ),
            SizedBox(width: 30,),
            Text(name, textAlign: TextAlign.center, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)  
          ],
        ),
      ),
    );
  }
}
