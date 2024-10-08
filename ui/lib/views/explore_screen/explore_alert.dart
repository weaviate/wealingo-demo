import 'package:ui/util/api.dart';
import 'package:ui/views/explore_screen/explore_screen.dart';
import 'package:flutter/material.dart';
import 'package:ui/util/constants.dart';

class ExploreAlertScreen extends StatefulWidget {
  
  @override
  _ExploreAlertDialogState createState() => _ExploreAlertDialogState();

}


class _ExploreAlertDialogState extends State<ExploreAlertScreen> {
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {  

    return AlertDialog(
          title: Text('Your personal tutor', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
          // content: Text('Generate tailored tutorials', style: TextStyle(color: Colors.blue),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(padding: EdgeInsets.only(top: 15, bottom: 15), child: Image.asset(
                'assets/icons/search_icon.png',
                height: 100,
                ),),
              Text(
                'Search for phrases to help you practise',
                // style: TextStyle(color: Colors.blue),
              ),
              SizedBox(height: 25),
              TextField(
                controller: _textController,
                maxLength: 300,
                maxLines: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'What are you looking for ..? ',
                  counterText: '', 
                ),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            // side: BorderSide(color: Colors.blue, width: 2), 
          ),
          actions: <Widget>[
            Center(
              child: SizedBox(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                    onPressed: () {
                      String userInput = _textController.text;
                      logger.info(userInput);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ExploreScreen(userInput),
                        ),
                      );
                    },
                    child: Text('Search', style: TextStyle(color: Colors.white, fontSize: 18),),
                    style: TextButton.styleFrom(
                      backgroundColor: Constants.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 16), // Background color of 'No'
                    ),
                  ),
                ),
              ),
            ),
          ],
        );

     
  }

}
