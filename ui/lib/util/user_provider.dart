import 'package:ui/util/api.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class User {
  final String? username;
  final String? email;
  final String? userID;

  User({required this.username, required this.email, required this.userID});

  String toJson() {
    return json.encode({
      "username" : username,
      "userID" : userID,
      "email" : email
    }); 
  }

  factory User.fromJson(String data) {
    dynamic user = json.decode(data);
    return User(username:user['username'], email:user['email'], userID:user['userID']); 
  }

  static Future<User> createNew(username, email) async {
    try {
      String url = "user/new";
      final Map<String, dynamic> data = {
        'username': username,
        'email' : email
      };
      final response = await API.post(url, json.encode(data));
      logger.info('back from post create new user');
      logger.info(response);  
      User user = User(username: response['username'] , email: response['email'], userID: response['userID']);
      return user;
    } catch (e) {
      logger.fine('in error');
      logger.fine(e);
      return Future.error(e);
      // return [];
    }
  }
}

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  UserProvider() {
    _loadUser();
  }

  void setUser(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', user.toJson()); // Ensure you're awaiting the future
      _user = user;
      notifyListeners();
    } catch (e) {
      logger.fine('Failed to save user: $e'); // Handle any potential errors
    }
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    // logger.info('in load user');
    // logger.info(userData);
    if (userData != null) {
      _user = User.fromJson(userData);
      notifyListeners();
    }
  }

  Future<void> refreshUser() async {
    await _loadUser();
  }

  void clearUser() async {
    _user = null;
    notifyListeners();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user'); 
  }

}