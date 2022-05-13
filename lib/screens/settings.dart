import 'package:flutter/material.dart';
import 'package:quraanproject/screens/playlist/playlist_screen.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({ Key? key }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("SETTINGS",style: TextStyle(
          fontFamily: "font4",
          fontSize: 30
        ),),
      ),
      body:Column(
    children: [
       settingsIcon(settingicon: IconButton(onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: ((context) => Playlist())));
       }, icon: Icon(Icons.playlist_add)), settingtext: "Playlist")  ,
       settingsIcon(settingicon: Icon(Icons.feedback), settingtext: "Feedback")  ,
       settingsIcon(settingicon: Icon(Icons.share), settingtext: "Share"),
       settingsIcon(settingicon: Icon(Icons.privacy_tip), settingtext: "Privacy Policy"),
       settingsIcon(settingicon: Icon(Icons.star), settingtext: "Rate Us"),
       settingsIcon(settingicon: Icon(Icons.info), settingtext: "About Us")
    ],
    ));
  }
}
Widget settingsIcon({required settingicon,required settingtext}){

return Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Row(
  
    children: [
  
          Container(
  
      
  
                 child: IconButton(onPressed: (){}, icon: settingicon),
  
      
  
               ),
  
               Text(settingtext,style: TextStyle(fontSize: 15,fontFamily: "font3"),)
  
    ],
  
  ),
);
}