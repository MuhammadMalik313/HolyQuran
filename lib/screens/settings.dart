import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:quraanproject/screens/playlist/playlist_screen.dart';
import 'package:quraanproject/terms%20and%20policy/policy.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "SETTINGS",
            style: TextStyle(fontFamily: "font4", fontSize: 30),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            Row(
              children: [
                settingsIcon(settingicon: Icons.playlist_add),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) => Playlist())));
                    },
                    child: Text("Playlist", style: TextStyle(fontSize: 20, fontFamily: "font3",color: Colors.black),
))
              ],
            ),
            Row(
              children: [
                settingsIcon(settingicon: Icons.feedback_outlined),
                TextButton(
                    onPressed: () {
                     
                    },
                    child: Text("Feedback", style: TextStyle(fontSize: 20, fontFamily: "font3",color: Colors.black),
))
              ],
            ),
            Row(
              children: [
                settingsIcon(settingicon: Icons.share),
                TextButton(
                    onPressed: () {
                      share();
                    },
                    child: Text("share", style: TextStyle(fontSize: 20, fontFamily: "font3",color: Colors.black),
))
              ],
            ),
            Row(
              children: [
                settingsIcon(settingicon: Icons.privacy_tip),
                TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return PolicyDialog(mdFileName: "privacy_policy.md");
                          });
                    },
                    child: Text("Privacy Policy", style: TextStyle(fontSize: 20, fontFamily: "font3",color: Colors.black),
))
              ],
            ),
            Row(
              children: [
                settingsIcon(settingicon: Icons.info),
                TextButton(
                    onPressed: () {
                      showAboutDialog(
                          context: context,
                          applicationIcon: Image.asset("assets/quranlogoicon.jpg",
                              width: 30, height: 30),
                          applicationName: "Noble Qur'an App",
                          applicationVersion: "Version 0.0.1",
                          applicationLegalese: "Devoloped by Muhammad Malik ");
                    },
                    child: Text("About Us", style: TextStyle(fontSize: 20, fontFamily: "font3",color: Colors.black),
))
              ],
            ),
          ]),
        ));
  }

  Future<void> share() async {
    await FlutterShare.share(
      title: 'app share',
      linkUrl: 'https://flutter.dev/',
    );
  }
}

Widget settingsIcon({required settingicon}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Icon(settingicon),
      ],
    ),
  );
}
