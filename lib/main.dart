import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quraanproject/screens/splash_screen.dart';

void main(List<String> args) {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "THE HOLY QURAN",
      theme: ThemeData(primarySwatch: Colors.grey),
      home:SecondClass());
    
  }
}