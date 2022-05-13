import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:quraanproject/screens/animationscreen/chapter_name.dart';
import 'package:quraanproject/screens/animationscreen/juzu.dart';
import 'package:quraanproject/screens/animationscreen/home_text.dart';
import 'package:quraanproject/screens/animationscreen/settings.dart';
import 'package:quraanproject/HomePage/favourite_button.dart';
import 'package:quraanproject/screens/audio_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future setData()async{
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("alreadyUsed", true);       
  }
  @override 
  Void? initState(){
    super.initState();
    setData();
  }
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;

    var _arabiccalender = HijriCalendar.now();
    var day = DateTime.now();
    var format = DateFormat.yMMMMd('en_US');
    var formatted = format.format(day);
    String tdata = DateFormat("hh:mm  a").format(DateTime.now());

    return WillPopScope(
      onWillPop: () async{SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: _size.height * 0.48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/34v1_ysvk_201215.jpg"),
                      // fit: BoxFit.cover,
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(children: [
                              WidgetSpan(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Text(
                                  _arabiccalender.longMonthName.toString(),
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Color.fromARGB(255, 109, 31, 140),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "font2"),
                                ),
                              )),
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    _arabiccalender.hDay.toString(),
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Color.fromARGB(255, 109, 31, 140),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "font2"),
                                  ),
                                ),
                              ),
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    "${_arabiccalender.hYear} AH",
                                    style: TextStyle(
                                        fontFamily: "font2",
                                        fontSize: 21,
                                        color: Color.fromARGB(255, 29, 4, 4)),
                                  ),
                                ),
                              )
                            ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            formatted,
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 38, 5, 5),
                                fontFamily: "font2"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            tdata,
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 53, 7, 7),
                                fontFamily: "font2"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              HomeText(),
              ChapterButton(),
              SizedBox(
                height: 20,
              ),
              JuzNameWidget(),
              SizedBox(
                height: 20,
              ),
              AudioName(),
              SizedBox(
                height: 20,
              ),
              FavouritesButton(),
              SettingsButton()
             
            ],
          ),
        ),
      ),
    );
  }
}


