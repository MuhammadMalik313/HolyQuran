import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quraanproject/model/data_model.dart';
import 'package:quraanproject/screens/play_audio.dart';
import 'package:quran/quran.dart' as quran;

import '../../main.dart';

class PlaylistSong extends StatefulWidget {
  String playlistName;
  PlaylistSong({ Key? key, required this.playlistName, }) : super(key: key);

  @override
  State<PlaylistSong> createState() => _PlaylistSongState();
}

class _PlaylistSongState extends State<PlaylistSong> {
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return  Scaffold(
        appBar: AppBar(
      
          title: Text("AUDIO INDEX"),
          centerTitle: true,
          brightness: Brightness.dark,
        ),
        body: AnimationLimiter(
          child: ValueListenableBuilder(
            valueListenable: playSongBox.listenable(),
            builder: (BuildContext ctx, Box<PlaylistSongs> playSongs, Widget? child) {
              return ListView.builder(
                padding: EdgeInsets.all(_w / 30),
                physics:
                    BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                itemCount: playSongs.length,
                itemBuilder: (BuildContext context, int index) {

                  PlaylistSongs? playSong = playSongs.getAt(index);
                  int surahno = index + 1;

                  if(playSong!.playListName == widget.playlistName){
                    return AnimationConfiguration.staggeredList(
                    position: index,
                    delay: Duration(milliseconds: 100),
                    child: SlideAnimation(
                      duration: Duration(milliseconds: 2500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      verticalOffset: -250,
                      child: ScaleAnimation(
                        duration: Duration(milliseconds: 1500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: Container(
                          child: ListTile(
                            title: Text(
                              quran.getSurahName(playSong.chapterNo),
                              style: TextStyle(fontSize: 20, fontFamily: "font3"),
                            ),
                            subtitle: Text(quran.getSurahNameEnglish(playSong.chapterNo)),
                            trailing: PopupMenuButton(
                                itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: Text("Remove"),
                                        onTap: (){
                                          deletePlaySong(playSong.chapterNo);
                                        },
                                        value: 1,
                                      ),
                                    ]),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) =>PlayAudio(index: playSong.chapterNo,)));
                                  // getAudio();
                            },
                            // onTap:  ,
                          ),
                          margin: EdgeInsets.only(bottom: _w / 20),
                          height: _w / 5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 40,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                  }else{
                    return SizedBox();
                  }
                  
                },
              );
            }
          ),
        ),
      );
  }
  deletePlaySong(int playSongId){
    print(playSongId);
    final Map<dynamic, PlaylistSongs> deliveriesMap = playSongBox.toMap();
    dynamic desiredKey;
    deliveriesMap.forEach((key, value){
        if (value.chapterNo == playSongId)
            desiredKey = key;
    });
    playSongBox.delete(desiredKey);
  }

}