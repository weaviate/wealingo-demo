import 'package:ui/util/api.dart';
import 'package:ui/util/constants.dart';
import 'package:ui/views/home_screen/components/explore_app_bar.dart';
import 'package:ui/views/lesson_screen/lesson_screen.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  final String searchInput;
  const ExploreScreen(this.searchInput, {Key? key}) : super(key: key);

  Future<List<dynamic>> _searchQuestions() async {
    logger.info('in search quesitons');
    String url = "questions/search/$searchInput";
    try {
      final response = await API.get(url);
      return response['questions'];
    } catch (e) {
      logger.fine('in error');
      logger.fine(e);
      return [];
    }
  }

  Widget build(BuildContext context) {
    logger.info('in search quesitons');
    return Scaffold(
      appBar: ExploreAppBar(),
      bottomNavigationBar: button(context, 'Home'),
      body: FutureBuilder(
        future: _searchQuestions(), 
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
                      return newsBox('assets/images/news-1.png',
                      questions[index]['question'],
                      questions[index]['answer'],
                      questions[index]['instruction']?? '');               
                  }
                )
              ],
            );
          } else {
            return Center(child: Text('No lessons available'));
          }
        },
      ),
    );
  }

  newsBox(String image, String title, String description, String date) {
    return Container(
      // height: 300,
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
          // imageBox(image),
          newsTitle(title),
          newsDescription(description),
          newsDate(date),
        ],
      ),
    );
  }

  newsTitle(String title) {
    return Container(      
      margin: EdgeInsets.only(left: 10, bottom: 10, right:10, top: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  newsDescription(String description) {
    return Container(
      margin: EdgeInsets.only(left: 10, bottom: 10, right:10, top: 0),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          description,
          style: const TextStyle(
            fontSize: 22,
            color: Colors.green,
          ),
        ),
      )
    );
  }

  newsDate(String date) {
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
                date,
                style: const TextStyle(
                  fontSize: 18,
                  // fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        // child:
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
          shape: RoundedRectangleBorder(
            // borderRadius: BorderRadius.circular(10),
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
