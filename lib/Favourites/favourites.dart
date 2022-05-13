import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quraanproject/model/data_model.dart';
import 'package:quraanproject/screens/play_audio.dart';
import 'package:quran/quran.dart' as quran;

import '../../main.dart';

class Favourite extends StatefulWidget {
  // String playlistName;
  Favourite({ Key? key, }) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
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
            valueListenable: favSongsBox.listenable(),
            builder: (BuildContext ctx, Box<Favourites> favSongs, Widget? child) {
              return ListView.builder(
                padding: EdgeInsets.all(_w / 30),
                physics:
                    BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                itemCount: favSongs.length,
                itemBuilder: (BuildContext context, int index) {

                  Favourites? favSong = favSongs.getAt(index);
                  int surahno = index + 1;

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
                              quran.getSurahName(favSong!.favNo),
                              style: TextStyle(fontSize: 20, fontFamily: "font3"),
                            ),
                            subtitle: Text(quran.getSurahNameEnglish(favSong.favNo)),
                            trailing: Icon(
                              Icons.play_circle_outline_rounded,
                              size: 35,
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) =>PlayAudio(index: favSong.favNo,)));
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
                  
                  
                },
              );
            }
          ),
        ),
      );
  }

}