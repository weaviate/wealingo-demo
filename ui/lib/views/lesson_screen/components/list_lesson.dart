import 'package:ui/util/api.dart';
import 'package:ui/util/constants.dart';
import 'package:ui/views/lesson_screen/components/bottom_button.dart';
import 'package:ui/views/lesson_screen/components/stage_changed.dart';
import 'package:flutter/material.dart';

class ListLesson extends StatefulWidget {
  Widget checkButton;
  String questionType;
  String question;
  List<String> answers;
  int correctAnswer;
  String instruction;

  ListLesson(
    this.questionType, this.question, 
    this.answers, this.correctAnswer, this.instruction,
    {required this.checkButton, Key? key}
    ) : super(key: key);

  @override
  _ListLessonWidgetState createState() => _ListLessonWidgetState();
}

class _ListLessonWidgetState extends State<ListLesson> {
  int? selectedAnswer = 1;

  @override
  Widget build(BuildContext context) {
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(padding: EdgeInsets.only(top: 5)),
        questionType(widget.questionType),
        const Padding(padding: EdgeInsets.only(top: 5)),
        questionRow(widget.question),
        Expanded(
          child : Center(
            child: ListView.builder(
              itemCount: widget.answers.length,
              itemBuilder: (context, index) {
                return listChoice(widget.answers[index], index);
              },
            ),
          ),
        ),
        instruction(widget.instruction),
        widget.checkButton,
      ],
    );
  }

  listChoice(String title, int index) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        // padding: const Padding(padding: EdgeInsets.only(bottom: 10),),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(
          width: 2.5,
          color: Colors.white,
        ),
      ),
      child: tile(index, widget.answers[index], widget.correctAnswer),
    );  
  }

  tile(index, text, correctAnswer) {
    return RadioListTile<int>(
      title: Text(text, 
            style: TextStyle(
                    fontSize: 21, 
                    color: selectedAnswer == index ? Colors.green : Colors.black, )),
      value: index,
      groupValue: selectedAnswer,
      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ), 
      selectedTileColor: Colors.green,
      onChanged: (value) {
        setState(() {
          selectedAnswer = value;
          bool isCorrect = index == widget.correctAnswer;
          _showSnackBar(isCorrect);
        });
      },
    );
  }  

  void _showSnackBar(bool isCorrect) {
  final snackBar = SnackBar(
    content: Container(
      height: 80, // Set the desired height
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center the content
        children: [
          Icon(
            isCorrect ? Icons.check_circle : Icons.error, // Use different icons for correct/incorrect
            color: isCorrect ? Colors.green : Colors.red, // Color of the icon
            size: 30, // Icon size
          ),
          const SizedBox(height: 10), // Space between the icon and text
          Text(
            isCorrect ? 'Good job!' : 'Incorrect',
            style: TextStyle(fontSize: 20, color: Constants.primaryColor), // Customize text
          ),
        ],
      ),
    ),
    backgroundColor: Colors.white,
    duration: Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
      left: 20,
      right: 20,
      bottom: MediaQuery.of(context).size.height * 0.3,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // Add rounded corners
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

  questionRow(String question) {
    return Container(
      margin: const EdgeInsets.only(left: 15, top: 20, bottom: 20),
      child: Row(
        children: [
          speakButton(),
          const Padding(padding: EdgeInsets.only(right: 15)),
          Flexible(
            child: Text(
              question,
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  ),
            ), 
          )
        ],
      ),
    );
  }

  instruction(String instruction) {
    return Container(
      margin: const EdgeInsets.only(left: 20, bottom: 55, right: 20),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          instruction,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            // color: Colors.black,
          ),
        ),
      ),
    );
  }

  speakButton() {
    return Container(
      padding: const EdgeInsets.all(5),
      child: const Icon(
        Icons.circle,
        size: 35,
      ),
    );
  }

  questionType(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 15),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            // color: Color(0xFF4B4B4B),
          ),
        ),
      ),
    );
  }
}
