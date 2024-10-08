import 'package:flutter/material.dart';

import 'components/course_node.dart';
import 'components/double_course_node.dart';
import 'components/triple_course_node.dart';
import 'package:logging/logging.dart';

final Logger logger = Logger('CourseTree');


class CourseTree extends StatelessWidget {
  const CourseTree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // logger.info('in build of course tree');
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(bottom: 25)),
          Text(
            "Let's start your journey",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
            textAlign: TextAlign.left, // Center align the text
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 2, // Restrict to two lines
          ),
          const Padding(padding: EdgeInsets.only(top: 15, bottom: 25)),
          CourseNode(
            'Basics',
            image: 'assets/icons/basics_icon.png',
            crown: 1,
          ),
          const Padding(padding: EdgeInsets.only(top: 15, bottom: 25),),
          DoubleCourseNode(
            CourseNode(
              'Introduce Yourself',
              image: 'assets/icons/introduce_yourself.png',
              color: Colors.yellow,
              percent: 1,
              crown: 1,
            ),
            CourseNode(
              'Navigate a City',
              image: 'assets/icons/navigate_city.png',
              color: const Color(0xFFCE82FF),
              crown: 2,
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 15, bottom: 45)),
          TripleCourseNode(
            CourseNode(
              'Talk about family and friends',
              image: 'assets/icons/talk_about.png',
              color: Colors.green,
              // percent: 0.2,
              crown: 3,
            ),
            CourseNode(
              'Order in a restaurant',
              image: 'assets/icons/order_restaurant.png',
              color: Colors.blue,
              percent: 1,
              crown: 1,
            ),
          // ),
          // const Padding(padding: EdgeInsets.all(10)),
            CourseNode(
              'Buy things in a store',
              image: 'assets/icons/buy_things_icon.png',
              color: Colors.redAccent,
              crown: 4,
            ),
          ),
          const Padding(padding: EdgeInsets.all(10)),
        ],
      ),
    );
  }
}
