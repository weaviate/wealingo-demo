import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CenterDisplay extends StatelessWidget {
  const CenterDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Container(padding: const EdgeInsets.only(top:155, left: 10)),
          Align(
            alignment: Alignment.center, // Aligns the image to the left
            child: Padding(
              padding: const EdgeInsets.only(right: 50, top:155,), // Add padding if needed
              child: Image.asset(
                'assets/icons/wealingo.png', 
                height: 150,
              ),
            ),
          ),
          Container(padding: const EdgeInsets.all(15)),
          Text('Wealingo',
              style: GoogleFonts.plusJakartaSans(
                textStyle: TextStyle(fontSize: 35, fontWeight: FontWeight.w700,),)),
          Container(padding: const EdgeInsets.all(15)),
          Text('Learn a language for free. Forever.',
              style: GoogleFonts.plusJakartaSans(
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,),)),
        ],
      ),
    );
  }
}
