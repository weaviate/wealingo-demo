import 'package:flutter/material.dart';

class ListQuiz extends StatefulWidget {
  final Widget checkButton;
  final String questionType;
  final String question;
  final List<String> answers;
  final int correctAnswer;
  final int difficulty;
  final Function(int, bool) onOptionSelected; 

  @override
  State<StatefulWidget> createState() {
    return _ListQuizState();
  }

  ListQuiz(
    this.questionType, this.question, 
    this.answers, this.correctAnswer,
    this.difficulty,
    {required this.checkButton,
    required this.onOptionSelected, 
    Key? key}
    ) : super(key: key);

}

class _ListQuizState extends State<ListQuiz> {  
  int? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 25, bottom: 25)),
        questionRow(widget.question),
        Expanded(
          child : Center(
            child: ListView.builder(
              itemCount: widget.answers.length,
              itemBuilder: (context, index) {
                return listChoice(widget.answers[index], widget.difficulty, index);
              },
            ),
          ),
        ),
        // const Spacer(),
        widget.checkButton,
      ],
    );
  }

  listChoice(String title, int difficulty, int index) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 20),
      padding: const EdgeInsets.all(10),
      // onPress: {},
      decoration: BoxDecoration(
        // padding: const Padding(padding: EdgeInsets.only(bottom: 10),),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(
          width: 2.5,
          color: Colors.white,
        ),
      ),
      child: tile(index, widget.answers[index], difficulty),
    );  
  }

  tile(index, text, int difficulty) {
    return RadioListTile<int>(
      title: Text(text, 
            style: TextStyle(
                    fontSize: 17, 
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
          widget.onOptionSelected(difficulty, isCorrect);         
          // _showSnackBar(isCorrect);
        });
      },
    );
  }  

  questionRow(String question) {
    return Container(
      margin: const EdgeInsets.all(20),
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

  speakButton() {
    return Container(
      padding: const EdgeInsets.all(5),
      child: const Icon(
        Icons.circle,
        size: 35,
      ),
    );
  }
}
