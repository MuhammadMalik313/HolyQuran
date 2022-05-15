import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:quraanproject/HomePage/home_page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: IntroductionScreen(
              globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: "READ QURAN",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                  "Cutomize your reading,Read, study,\nand learn the Noble Quran.\nAlso keep in mind ,reading from the actual holy book\nand memorising it is the most favoured method."),
            ],
          ),
          image: Center(child: Image.asset("assets/onboardingimg1.jpg")),
        ),
        PageViewModel(
            title: "LISTEN QURAN",
            bodyWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Listen to different Audios and learn thajweed,\nListening of the Holy Quran\nremoves negative emotions,\nand creates a sense of relaxation.",
                ),
              ],
            ),
            image: Center(child: Image.asset("assets/onboardingimg2.jpg"))),
        PageViewModel(
          title: "BUILD BETTER HABITS",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                  "Make islamic practices a part of your daily life \nin a way that best suits your daily life"),
            ],
          ),
          image: Center(child: Image.asset("assets/onboardingimg3.jpg")),
        )
      ],
      onDone: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },
      
      showNextButton: true,
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.black,
      ),
      done: const Text("Done",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
      dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0))),
    )));
  }
}
