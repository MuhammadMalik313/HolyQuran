import 'package:flutter/material.dart';
import 'package:quraanproject/functions/db_functions.dart';
import 'package:quraanproject/model/data_model.dart';
import 'package:quraanproject/screens/playlist/playlist_videos.dart';

class Playlist extends StatefulWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  final _playListController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getAllPlaylist();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(//#########################################
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
                      onAddButton() async {
                        final _playlist = _playListController.text;
                        if (_playlist.isEmpty) {
                          return;
                        }
                        print("$_playlist");
                        final _playlist1 = PlayListModel(name: _playlist);
                        addPlaylist(_playlist1);
                      }

                      ;
                    },
                    icon: Icon(Icons.add),
                    label: Text("add"),
                  )
                ],
              ),
            ),
            Expanded(//#########################################
                child: ValueListenableBuilder(
                    valueListenable: PlayListNotifier,
                    builder: (BuildContext ctx, List<PlayListModel> playlist,
                        Widget? child) {
                      return ListView.separated(
                          itemBuilder: ((ctx, index) {
                            final data = playlist[index];
                            return ListTile(
                              onTap: () {
                                print("object");//####go to play list song section
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>PlaylistSong(playlistName: data.name,)));
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
