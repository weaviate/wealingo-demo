import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PolicyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: 14.0,
          height: 1.5,
          color: Colors.grey.shade600,
        ),
        children: const <TextSpan>[
          TextSpan(text: 'By signing in to Wealingo, you agree to our '),
          TextSpan(
              text: 'Terms', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: ' and '),
          TextSpan(
              text: '\nPrivacy Policy',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
