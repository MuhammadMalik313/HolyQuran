import 'package:flutter/material.dart';
import 'package:quraanproject/model/data_model.dart';
import 'package:quraanproject/screens/new_splash_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box<PlaylistSongs> playSongBox;

Future main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(PlayListModelAdapter().typeId)) {
    Hive.registerAdapter(PlayListModelAdapter());
    Hive.registerAdapter(PlaylistSongsAdapter());
  }

  playSongBox = await Hive.openBox<PlaylistSongs>("playlist_songs");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "THE HOLY QURAN",
        theme: ThemeData(primaryColor: Color.fromARGB(255, 38, 94, 189)),
        home: SplashScreen1());
  }
}
