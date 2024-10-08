import 'package:ui/util/constants.dart';
import 'package:ui/util/user_provider.dart';
import 'package:ui/views/app.dart';
import 'package:ui/views/quiz_screen/components/quiz_node.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../course_screen/components/course_node.dart';

class QuizScreenLevels extends StatelessWidget {
  const QuizScreenLevels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {    
    String? username;
    try {
      final user = Provider.of<UserProvider>(context).user;   
      // logger.info(user);
      if(user != null && user.username != 'Guest') {
        username = user.username;
      } else {

        return AlertDialog(
          title: Padding(padding: EdgeInsets.all(30),
          child: Text('You need to sign in to play the Quiz', 
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), 
                  textAlign: TextAlign.center,),),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          actions: <Widget>[
            Center(
              child: SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                    
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text('Yes', style: TextStyle(color: Constants.primaryColor, fontSize: 18),),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: Constants.primaryColor, width: 1) 
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Text(
                      'No', 
                      style: TextStyle(color: Colors.white, fontSize: 18,), // Red text color and increased font size
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Constants.primaryColor, // Background color of 'No'
                      padding: EdgeInsets.symmetric(vertical: 16), // Increased padding to make button larger
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    } catch (e) {
      logger.finer(e);
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(35),
            child: Image.asset(
                  'assets/icons/quiz_icon.png',
                  height: 100,
                  ),),  
          QuizNode(
            'Basic',
            level: 2,
            image: 'assets/icons/basic_quiz.png'
          ),
          const Padding(padding: EdgeInsets.all(10)),
          QuizNode(
            'Intermediate',
            level: 4,
            image: 'assets/icons/intermediate_quiz.png',
          ),
          const Padding(padding: EdgeInsets.all(10)),
          QuizNode(
            'Expert',
            image: 'assets/icons/expert_quiz.png',
            // color: Colors.redAccent,
            level: 5,
          ),
          const Padding(padding: EdgeInsets.all(10)),
        ],
      ),
    );
  }
}
