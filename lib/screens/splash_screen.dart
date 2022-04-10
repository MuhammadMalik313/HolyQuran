import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quraanproject/screens/onboarding_screen.dart';

class SecondClass extends StatefulWidget {
  @override
  _SecondClassState createState() => _SecondClassState();
}

class _SecondClassState extends State<SecondClass>
    with TickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            Navigator.of(context).pushReplacement(
              PageTransition(
                type: PageTransitionType.bottomToTop,
                child: OnBoardingScreen(),
              ),
            );
            Timer(
              Duration(milliseconds: 300),
              () {
                scaleController.reset();
              },
            );
          }
        },
      );

    scaleAnimation =
        Tween<double>(begin: 0.0, end: 12).animate(scaleController);

    Timer(Duration(seconds: 8), () {
      setState(() {
        scaleController.forward();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: 
          Column(
            children: [
              Container(
                height: 400,width: 800,
                child: 
                Image.asset('assets/quran5.jpg')

                ),
                SizedBox(height: 50,),
              Center(
                child: DefaultTextStyle(
                  style: TextStyle(fontSize: 50.0),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        ' HOLY\nQURAN',
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 80, 80, 80),
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 50,
                        ),
                        speed: Duration(milliseconds: 170),
                      ),
                      TyperAnimatedText(
                           'القران الكريم ',
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 80, 80, 80),
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 50,
                        ),
                        speed: Duration(milliseconds: 170),
                      ),
                    ],
                    isRepeatingAnimation: false,
                    repeatForever: false,
                    displayFullTextOnTap: false,
                  ),
                ),
              ),
            ],
          ),
          
        ),
      );
    
  }
}
