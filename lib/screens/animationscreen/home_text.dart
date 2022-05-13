import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class HomeText extends StatefulWidget {
  const HomeText({ Key? key }) : super(key: key);

  @override
  State<HomeText> createState() => _HomeTextState();
}

class _HomeTextState extends State<HomeText> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'READ,LEARN AND LISTEN',
              speed: Duration(milliseconds: 150),
              textStyle: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                fontFamily: "font8",
                color: Color.fromARGB(255, 169, 50, 50)
              ),
            ),
          ],
          isRepeatingAnimation: true,
          repeatForever: true,
          displayFullTextOnTap: true,
          stopPauseOnTap: false,
        ),
      );
    
  }
}