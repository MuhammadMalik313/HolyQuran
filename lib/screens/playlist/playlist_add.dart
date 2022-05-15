import 'package:flutter/material.dart';
import 'package:quraanproject/functions/db_functions.dart';
import 'package:quraanproject/main.dart';
import 'package:quraanproject/model/data_model.dart';

class AddPlaylist extends StatefulWidget {
  int songIndex;

  AddPlaylist({Key? key, required this.songIndex}) : super(key: key);

  @override
  State<AddPlaylist> createState() => _AddPlaylistState();
}

class _AddPlaylistState extends State<AddPlaylist> {
  final _playListController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getAllPlaylist();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("PLAYLIST"),
        ),
        body: Column(
          children: [
            Padding(
              //#########################################
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _playListController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "add new category"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      final _playlist = _playListController.text;
                      if (_playlist.isEmpty) {
                        return;
                      }
                      print("$_playlist");
                      final _playlist1 = PlayListModel(name: _playlist);
                      addPlaylist(_playlist1);
                    },
                    icon: Icon(Icons.add),
                    label: Text("add"),
                  ),
                ],
              ),
            ),
            Expanded(
                //#########################################
                child: ValueListenableBuilder(
                    valueListenable: PlayListNotifier,
                    builder: (BuildContext ctx, List<PlayListModel> playlist,
                        Widget? child) {
                      return ListView.separated(
                          itemBuilder: ((ctx, index) {
                            final data = playlist[index];
                            return ListTile(
                              onTap: () {
                                //song add section
                                //##########################song add to play list sec
                                final playlistSong = PlaylistSongs(
                                  playListName: data.name,
                                  song:
                                      "https://server7.mp3quran.net/s_gmd/${widget.songIndex}.mp3",
                                  chapterNo: widget.songIndex,
                                );
                                if (checkWatchlater(playlistSong)) {
                                  playSongBox.add(playlistSong);
                                  Navigator.pop(context);
                                  print("added");
                                } else {
                                  Navigator.pop(context);
                                  print("Already exists");
                                }
                                print(playSongBox.length);
                              },
                              //########################################section end
                              title: Text(data.name),
                            );
                          }),
                          separatorBuilder: (ctx, index) {
                            return Divider(
                              thickness: 1,
                            );
                          },
                          itemCount: playlist.length);
                    })),
          ],
        ),
      ),
    );
  }

  //#####################song in db or not checking
  checkWatchlater(PlaylistSongs playlistsSong) {
    if (playSongBox.isNotEmpty) {
      List<PlaylistSongs> playlistSong = playSongBox.values.toList();
      final isExists = playlistSong
          .where((itemToCheck) => itemToCheck.song == playlistsSong.song);
      if (isExists.isEmpty) {
        return true; //no matching element found
      } else {
        return false; //matching element found in db
      }
    }
    return true;
  }
}
