import 'package:ui/util/api.dart';
import 'package:ui/util/constants.dart';
import 'package:ui/views/generative_screen/generative_screen.dart';
import 'package:ui/views/lesson_screen/lesson_screen.dart';
import 'package:flutter/material.dart';


class GenerativeAlertScreen extends StatefulWidget {
  
  @override
  _GenerativeAlertDialogState createState() => _GenerativeAlertDialogState();

}


class _GenerativeAlertDialogState extends State<GenerativeAlertScreen> {
  String selectedValue = 'Introduce yourself'; 
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {  

    return AlertDialog(
          title: Text('Your personal tutor', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(padding: EdgeInsets.only(top: 15, bottom: 15), child: Image.asset(
                'assets/icons/personal-tutor.png',
                height: 100,
                ),),
              Text(
                'Create your own lessons \n Move at your own pace',
                // style: TextStyle(color: Colors.blue),
              ),
              SizedBox(height: 25),
              TextField(
                controller: _textController,
                maxLength: 200,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'What do you wanna say ..? ',
                  counterText: '', // To remove the default character counter
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            // side: BorderSide(color: Colors.blue, width: 2), // Blue border
          ),
          actions: <Widget>[
            Center(
              child: SizedBox(
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                    onPressed: () {
                      // logger.info(selectedValue);
                      String userInput = _textController.text;
                      // logger.info(userInput);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GenerativeScreen(selectedValue="", userInput),
                        ),
                      );
                    },
                    child: Text('Next', 
                      style: TextStyle(color: Colors.white, fontSize: 18),),
                    style: TextButton.styleFrom(
                      backgroundColor: Constants.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 16), 
                    ),
                  ),
                ),
              ),
            ),
          ],
        );

     
  }

}
