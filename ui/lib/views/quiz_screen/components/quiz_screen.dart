import 'package:ui/util/api.dart';
import 'package:ui/util/user_provider.dart';
import 'package:ui/views/leaderboard_screen/leaderboard_screen.dart';
import 'package:ui/views/lesson_screen/components/bottom_button.dart';
import 'package:ui/views/lesson_screen/components/lesson_app_bar.dart';
import 'package:ui/views/quiz_screen/components/list_quiz.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';

import 'package:provider/provider.dart';

class QuizScreen extends StatefulWidget {
  final int? level;

  const QuizScreen ({ required this.level});

  @override
  State<StatefulWidget> createState() {
    return QuizScreenState();
  }
}

class QuizScreenState extends State<QuizScreen> {
  double percent = 0.2;
  int index = 0;
  late Future<List<dynamic>> questions;
  List<Map<String, dynamic>> questionResponses = [];
  int totalScore = 0;
  int currentScore = 0;
  var newLessons = []; 

  @override
  void initState() {
    super.initState();
    questions = _loadQuestions(widget.level);
  }

  void _postScoretoLeaderboard(userID, totalScore, questionResponses) async {
    try {
      String url = "quiz/score";
      final Map<String, dynamic> data = {
        'user_id': userID,
        'totalScore' : totalScore,
        'responses' : questionResponses
      };
      final response = await API.post(url, json.encode(data));
      // logger.info(response);
    } catch (e) {
      logger.fine('in error');
      logger.fine(e);
      // return [];
    }
  }

  Future<List<dynamic>> _loadQuestions(level) async {
    // logger.info('fetching quiz questions $level');
    String url = "quiz/level/$level";
    try {
      final response = await API.get(url);
      // logger.info(response['questions']);
      return response['questions'];
    } catch (e) {
      logger.fine('in error');
      logger.fine(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: questions, 
      builder: (context, snapshot) {   
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {     
        // if(snapshot.hasData) {
          List questions = snapshot.data as List<dynamic>;
          // logger.info(questions);
          for (int i=0; i< questions.length; i++) {
            String options = questions[i]['options'];
            String answer = questions[i]['answer'];
            List<String> optionsList = options.split(";");
            optionsList.add(answer);
            optionsList.shuffle(Random());
            int chosen = optionsList.indexOf(answer);
            newLessons.add(
              ListQuiz('Translate the sentence', questions[i]['question'],
              optionsList, chosen, questions[i]['difficulty_rating'],
              checkButton: bottomButton(context, 'NEXT'),
              onOptionSelected: (points, isCorrect) {             
                logger.info('currentScore: $currentScore');
                if(!isCorrect) {
                  currentScore = 0;
                  int index = questionResponses.indexWhere((result) => result['question_id'] == questions[i]['question_id']);
                  if (index != -1) {
                    questionResponses[index]['isCorrect'] = isCorrect;
                  } else {
                    questionResponses.add({
                      'question_id': questions[i]['question_id'],
                      'category': questions[i]['category'],
                      'isCorrect': isCorrect,
                    });
                  }
                } else {
                  currentScore = points;
                }
              }));
          }
          // logger.info(newLessons);
          // return Scaffold(
          //   appBar: LessonAppBar(percent: percent),
          //   body: newLessons[index],
          // );


          return Scaffold(
            appBar: LessonAppBar(percent: percent),
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
                newLessons[index],
              ],
            )
          );
        } else {
          return Text('');
        }      
      }
    );
  } 



  bottomButton(BuildContext context, String title) {
    final user = Provider.of<UserProvider>(context).user;
    String? userID;
    
    if(user != null) {
      userID = user.userID;
    }

    return Center(
      child: Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              // logger.info('currentScore: $currentScore');
              totalScore += currentScore;
              if (index < 4) {                
                logger.info('totalScore: $totalScore');
                index++;
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    _postScoretoLeaderboard(userID, totalScore, questionResponses);
                    return dialog('Your score $totalScore ');
                  },
                ).then((_) {
                    Navigator.pushNamed(context, '/home');
                });
                
              }
            });
          },
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF58CC02),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  dialog(String title) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: const BoxDecoration(color: Color(0xFFd7ffb8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            dialogTitle(title),
            BottomButton(context, title: 'CONTINUE'),
          ],
        ),
      ),
    );
  }

  dialogTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.only(left: 15),
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xFF43C000),
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
