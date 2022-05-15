import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quraanproject/HomePage/home_page.dart';
import 'package:quraanproject/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({ Key? key }) : super(key: key);

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
        bool alreadyUsed=false; 
void getData()async{
final prefs = await SharedPreferences.getInstance();
alreadyUsed=prefs.getBool("alreadyUsed")?? false;

}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    getData();

    Timer(Duration(seconds: 3), () => Navigator.pushReplacement(context,
    MaterialPageRoute(builder: (context) {
      return alreadyUsed? HomePage(): OnBoardingScreen();})
    ),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Center(child: Image.asset("assets/quran.png",width: 300,height: 300,)),
          ),
          Padding(
            padding: const EdgeInsets.only(top:100),
            child: Center(child: Text("HOLY QUR'AN",style: TextStyle(fontSize: 45,fontFamily: "font4",fontWeight: FontWeight.bold,color: Color.fromARGB(255, 11, 117, 87)),)),
          )
        ],
      ),
    );
  }
}