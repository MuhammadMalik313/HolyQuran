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
                                final playlistSong = PlaylistSongs(
                                    playListName: data.name,
                                    song:
                                        "https://server7.mp3quran.net/s_gmd/${widget.songIndex}.mp3");
                                playSongBox.add(playlistSong);
                                print(playSongBox.length);
                              },
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
}
