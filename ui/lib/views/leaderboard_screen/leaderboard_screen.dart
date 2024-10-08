import 'package:ui/util/api.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  Future<List<dynamic>> _showLeaderboard() async {
    logger.info('fetching leaderboard');
    String url = "leaderboard";
    try {
      final response = await API.get(url);
      return response['leaderboard'];
    } catch (e) {
      logger.fine('in error');
      logger.fine(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {

    var ranks = List<int>.generate(30, (i) => i + 1);
    late List leaderboard;
    Random random = Random();
    var xps = List<int>.generate(30, (i) => random.nextInt(1000));
    var nameList = ['White', 'Red', 'Blue', 'Yellow', 'Cyan', 'Black', 'Pink', 'Purple'];
    var imageList = ['white.png', 'profile.jpg', 'green.png',
      'cyan.png', 'yellow.png'];

    var names = List<String>.generate(30, (i) => nameList[random.nextInt(nameList.length)]);
    var images = List<String>.generate(30, (i) => 'assets/images/' + imageList[random.nextInt(imageList.length)]);

    return FutureBuilder(
      future: _showLeaderboard(), 
      builder: (context, snapshot) {  
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          leaderboard = snapshot.data as List<dynamic>;
          logger.info(leaderboard);

          return Container(
            margin: EdgeInsets.all(30),
            decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
            child: ListView.builder(
                  itemCount: leaderboard.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.only(top: 17),
                      horizontalTitleGap: 12,
                      leading: rank(ranks[index]),
                      title: avatarWithName(images[index], leaderboard[index]['username']),
                      trailing: xpAmount(leaderboard[index]['xp']),
                    );
                  },
                )
          );
        }  else {
          return Text('');
        } 
      }
    );
  }

  xpAmount(int xp) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      child: Text(
        '$xp XP',
        style: const TextStyle(fontSize: 17),
      ),
    );
  }

  avatarWithName(String image, String name) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          avatar(image),
          const Padding(padding: EdgeInsets.only(right: 20)),
          friendName(name),
        ],
      ),
    );
  }

  friendName(String name) {
    return Text(
      name,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xFF4B4B4B),
        fontSize: 20,
      ),
    );
  }

  avatar(String image) {
    return Container(
      // padding: const EdgeInsets.only(top: 5),
      // margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundImage: AssetImage(image),
        radius: 22,
      ),
    );
  }

  rank(int rank) {
    return Container(
      margin: const EdgeInsets.only(left: 15),
      child: Text(
        '$rank',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF58CC02),
        ),
      ),
    );
  }
}
