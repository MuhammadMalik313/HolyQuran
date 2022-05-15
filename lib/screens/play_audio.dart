import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:quraanproject/screens/audio_name.dart';
import 'package:quraanproject/HomePage/home_page.dart';
import 'package:quraanproject/screens/playlist/playlist_add.dart';
import 'package:quran/quran.dart' as quran;

import '../Favourites/fav_button.dart';

dynamic count;

class PlayAudio extends StatefulWidget {
  int index;

  PlayAudio({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<PlayAudio> createState() => _PlayAudioState();
}

class _PlayAudioState extends State<PlayAudio> {
  // var url = "https://server7.mp3quran.net/s_gmd/$count.mp3";
  AudioPlayer audioPlayer = AudioPlayer();
  dynamic totalDuration = "00:00";
  dynamic position1 = "00:00";
  String? audioState;

  Duration duration = Duration();
  Duration position = Duration();
  bool playing = true;

  initAudio() {
    audioPlayer.onDurationChanged.listen((updatedDuration) {
      setState(() {
        totalDuration = updatedDuration;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
      setState(() {
        position = updatedPosition;
      });
    });
  }

  @override
  void initState() {
    count = widget.index.toString().padLeft(3, "0");

    initAudio();
    super.initState();

    getAudio();
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
          return SlideAnimation4();
        }));
        audioPlayer.stop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (Route<dynamic> route) => true);

                audioPlayer.stop();
              },
              icon: Icon(Icons.arrow_back_rounded)),
          centerTitle: true,
          title: Text(
            "PLAY AUDIO",
            style: TextStyle(fontFamily: "font4", fontSize: 30),
          ),
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: _size.height * 0.50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/audioimg.jpg"),
                  )),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: Text(
                            'Surath ${quran.getSurahName(widget.index)}',
                            style: TextStyle(
                                fontSize: 40,
                                color: Color.fromARGB(255, 53, 7, 7),
                                fontFamily: "font6"),
                          ),
                        ),
                        Text(
                          'سورة ${quran.getSurahNameArabic(widget.index)}',
                          style: TextStyle(
                              fontSize: 40,
                              color: Color.fromARGB(255, 53, 7, 7),
                              fontFamily: "font2",
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                slider(),
                ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 43),
                    child: Text(
                      position.toString().split(".").first,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 8, bottom: 43),
                    child: Text(
                      totalDuration.toString().split(".").first,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyCustomWidget(
                      favIndex: widget.index,
                    ), //###################################
                    Padding(
                      padding: const EdgeInsets.only(bottom: 23),
                      child: IconButton(
                          onPressed: () {
                            if (widget.index == 1) {
                              return;
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => PlayAudio(
                                    index: widget.index - 1,
                                  ),
                                ),
                              );
                            }

                            audioPlayer.stop();
                            count--;
                            getAudio();
                            Icon(
                              playing == true
                                  ? Icons.play_circle_fill_outlined
                                  : Icons.pause_circle_filled_outlined,
                              size: 50,
                            );

                            // audioPlayer.pause();
                          },
                          icon: Icon(
                            Icons.skip_previous_outlined,
                            size: 50,
                          )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      splashColor: Colors.grey,
                      onTap: () {
                        getAudio();
                      },
                      child: Icon(
                        playing == true
                            ? Icons.play_circle_fill_outlined
                            : Icons.pause_circle_filled_outlined,
                        size: 70,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 23),
                      child: IconButton(
                        onPressed: () {
                          if (widget.index == 114) {
                            return;
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => PlayAudio(
                                      index: widget.index + 1,
                                    )));
                            audioPlayer.stop();
                            count++;
                            getAudio();
                          }
                        },
                        icon: Icon(
                          Icons.skip_next_outlined,
                          size: 50,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    IconButton(
                        onPressed: () {
                          audioPlayer.stop();

                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  AddPlaylist(
                                songIndex: widget.index,
                              ),
                              transitionDuration: Duration(seconds: 0),
                            ),
                          );
                        },
                        icon: Icon(Icons.playlist_add)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget slider() {
    return Slider.adaptive(
      min: 0.0,
      value: position.inSeconds.toDouble(),
      max: duration.inSeconds.toDouble(),
      onChanged: (double value) {
        setState(() {
          audioPlayer.seek(Duration(seconds: value.toInt()));
        });
      },
    );
  }

  void getAudio() async {
    var url = "https://server7.mp3quran.net/s_gmd/$count.mp3";

    if (playing) {
      var res = await audioPlayer.play(url, isLocal: true);
      if (res == 1) {
        setState(() {
          playing = false;
        });
      }
    } else {
      var res = await audioPlayer.pause();
      if (res == 1) {
        setState(() {
          playing = true;
        });
      }
    }
    audioPlayer.onDurationChanged.listen((Duration dd) {
      setState(() {
        duration = dd;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((Duration dd) {
      setState(() {
        position = dd;
      });
    });
  }
}
