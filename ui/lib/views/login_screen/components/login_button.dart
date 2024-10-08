import 'package:ui/shared/firebase_authentication.dart';
import 'package:ui/util/user_provider.dart';
import 'package:ui/views/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/util/constants.dart';

class LoginButton extends StatefulWidget {
  final FirebaseAuthentication auth;
  final TextEditingController _usernameController;
  // final TextEditingController passwordController;

  const LoginButton(this.auth, this._usernameController,
      {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginButtonState();
  }
}

class LoginButtonState extends State<LoginButton> {
  String loginMessage = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(loginMessage),
        Container(padding: const EdgeInsets.all(5)),
        Container(
          width: 350,
          height: 50,
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          padding: const EdgeInsets.only(bottom: 2),
          child: ElevatedButton(
            child: Text(
              'Sign up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor:Constants.primaryColor,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: loginPressed,
          ),
        ),
      ],
    );
  }

  loginPressed() {
    String username = widget._usernameController.text;
    if (username.isEmpty) {
      logger.fine('Username cannot be empty');
      _showSnackBar('Username cannot be empty');
      return;
    }

    widget.auth.loginWithUserID(username).then((value) async {
      if (value == null) {
          logger.fine('user id auth failed');
      } else {
          logger.info(value);
          // String? username = value;
          User user = await User.createNew(username, 'anon');   
          Provider.of<UserProvider>(context, listen: false).setUser(user);   
          Navigator.pushNamed(context, '/home');
      }
    });
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating, // Make the Snackbar floating
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: MediaQuery.of(context).size.height * 0.4), // Position it vertically
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
