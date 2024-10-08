import 'package:ui/util/api.dart';
import 'package:ui/views/generative_screen/generative_alert.dart';
import 'package:ui/views/home_screen/components/generative_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:ui/util/user_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:ui/util/constants.dart';

class GenerativeScreen extends StatelessWidget {
  final String? category;
  final String? query;

  const GenerativeScreen(this.category, this.query, {Key? key}) : super(key: key);

  Future<List<dynamic>> _generateQuestions(userID) async {
    final Map<String, dynamic> data = {
        'user_id': userID,
        'category' : category,
        'query' : query
      };
    String url = 'questions/create';  
    try {
      final response = await API.post(url, json.encode(data));
      return response['questions'];
    } catch (e) {
      logger.fine('in error');
      logger.fine(e);
      return [];
    }
  }

  Widget build(BuildContext context) {
    String? userID;
    final userProvider = Provider.of<UserProvider>(context);
    try {
      final user = userProvider.user;    
      if(user != null) {
        userID = user.userID;
      } 
    } catch (e) {
      logger.finer(e);
    }
    return Scaffold(
      appBar: GenerativeScreenAppBar(), 
      body: FutureBuilder(
        future: _generateQuestions(userID), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final questions = snapshot.data as List<dynamic>;

            return Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/slide-bg-grain2.png', // Replace with your image path
                    fit: BoxFit.cover, // Makes sure the image covers the whole screen
                  ),
                ),
                ListView.builder(
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    logger.info(questions[index]);
                    return newsBox('assets/images/news-1.png',
                      questions[index]['question'],
                      questions[index]['answer'],
                      questions[index]['instruction']??'');
                  }
                ),
              ],
            );
          } else {
            return Center(
              child: button(context, 'Try again')
            );
          }
        },
      ),
      bottomNavigationBar: button(context, 'Home'),
    );
  }

  newsBox(String image, String question, String answer, String instruction) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 5, top: 15, left: 15, right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 2.5,
          color: Constants.primaryColor,
        ),
      ),
      child: Column(
        children: [
          newsTitle(question),
          newsDescription(answer),
          newsDate(instruction),
        ],
      ),
    );
  }

  newsTitle(String question) {
    return Container(
      margin: const EdgeInsets.only(left: 15, bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          question,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  newsDescription(String answer) {
    return Container(
      margin: EdgeInsets.only(left: 10, bottom: 10, right:10, top: 0),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          answer,
          style: const TextStyle(
            fontSize: 22,
            // fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
    );
  }

  newsDate(String instruction) {
    return Container(
      margin: EdgeInsets.only(left: 20, bottom: 20, right:20, top: 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Constants.primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
             Padding(padding: EdgeInsets.only(top: 15, bottom: 15, right:15, left:10), 
              child: Image.asset(
                'assets/icons/wealingo-icon.png',
                height: 50,
            ),),
            Flexible(
              child: Text(
                instruction,
                style: const TextStyle(
                  fontSize: 18,
                  // fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }  

  button(context, text) {
    return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/home');
        },        
        style: ElevatedButton.styleFrom(
          backgroundColor: Constants.primaryColor,
          elevation: 5,
          padding: const EdgeInsets.all(20),
          shape: const RoundedRectangleBorder(
          ),
        ),
        child: Text(
          '$text',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
  }
}
