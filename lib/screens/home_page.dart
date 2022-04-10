import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;

    var _arabiccalender = HijriCalendar.now();
    var day = DateTime.now();
    var format = DateFormat('EEEEE,d/MM/yyyy');
    var formatted = format.format(day);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: _size.height * 0.35,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/homepageimg3.jpg"),
                    fit: BoxFit.cover,
                  )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          WidgetSpan(
                              child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              _arabiccalender.longMonthName.toString(),
                              style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                _arabiccalender.hDay.toString(),
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                "${_arabiccalender.hYear} AH",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          )
                        ]),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        formatted,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "ذَٰلِكَ ٱلْكِتَـٰبُ لَا رَيْبَ ۛ فِيهِ ۛ هُدًۭى لِّلْمُتَّقِينَ۝",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 13, right: 20),
              child: Text(
                "This is the Book (The Quran) about which there is no doubt, a guidance for those who have conscious of God.\n\n[Holy Quran | 2:2]",
                style:TextStyle(fontFamily:"Schyler")
                
              ),
            )
          ],
        ),
      ),
    );
  }
}


