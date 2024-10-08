import 'package:ui/shared/firebase_authentication.dart';
import 'package:ui/views/app.dart';
import 'package:ui/util/constants.dart';
import 'package:ui/views/login_screen/components/facebook_button.dart';
import 'package:ui/views/login_screen/components/forgot_password.dart';
import 'package:ui/views/login_screen/components/google_button.dart';
import 'package:ui/views/login_screen/components/login_button.dart';
import 'package:ui/views/login_screen/components/policy_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'components/app_bar.dart';
import 'components/input_field.dart';
import '../../firebase_options.dart';
import 'dart:math';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();

  late FirebaseAuthentication auth;
  late Future<void> _firebaseInitialization;

  String loginMessage = '';

  @override
  void initState() {
    super.initState();
    _firebaseInitialization = _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    logger.info(DefaultFirebaseOptions.currentPlatform);
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
    ).whenComplete(() {
      auth = FirebaseAuthentication();
      setState(() {});
    });
  }

  String generateRandomUsername() {
    const length = 15;
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();

    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseInitialization, // Return a Future from _initializeFirebase
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Loading indicator
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // Error handling
        }

        return Scaffold(
          appBar: const LoginAppBar(),
          body: Container(  
            alignment: Alignment.topCenter,
            color: Constants.secondaryColor,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(padding: EdgeInsets.only(top: 10, bottom: 30),
                  child: Text(
                    'To get started create a username',
                    style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold,),
                    ),
                  ),
                  // SizedBox(height: 20),
                  Container(
                    width: 350,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: _usernameController,
                      maxLength: 15,                  
                      decoration: const InputDecoration(
                        labelText: 'Enter Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                        hintText: 'Username or email',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _usernameController.text = generateRandomUsername();
                      });
                    },
                    child: const Text(
                      'Generate Username',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 5,
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      fixedSize: Size(350, 50)
                    ),
                  ),
                  SizedBox(height: 250),                
                  LoginButton(auth, _usernameController),
                  SizedBox(height: 30),  
                  Text(
                    'Or login with',
                    style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold,),
                  ),
                  SizedBox(height: 30),  
                  GoogleButton(auth),    
                  // bottomDisplay(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bottomDisplay() {
    return Container(
      child: Align(
        // alignment: FractionalOffset.bottomCenter,
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PolicyText(),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
