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
  @override
  Widget build(BuildContext context) {
    final _playListController = TextEditingController();
    getAllPlaylist();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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

                      ;
                    },
                    icon: Icon(Icons.add),
                    label: Text("add"),
                  )
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
                              trailing: PopupMenuButton(
                                  itemBuilder: (context) => [
                                        PopupMenuItem(
                                          child: Text("Remove"),
                                          onTap: () {
                                            deletePlaylist(data.name);
                                          },
                                          value: 1,
                                        ),
                                        PopupMenuItem(
                                          child: Text("Edit"),
                                          onTap: () {
                                            Widget playlistAdd(context) {
                                              return FloatingActionButton(
                                                onPressed: () {},
                                                child: IconButton(
                                                  onPressed: () {
                                                    playlistPopup(context);
                                                  },
                                                  icon: const Icon(Icons.add,
                                                      size: 30,
                                                      color: Colors.white),
                                                ),
                                              );
                                            }
                                          },
                                          value: 1,
                                        ),
                                      ]),
                              onTap: () {
                                print(
                                    "object"); //####go to play list song section
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PlaylistSong(
                                              playlistName: data.name,
                                            )));
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

playlistPopup(context) {
  final GlobalKey<FormState> _formKey =
      GlobalKey(); //currentstate.validate not work without <FormState>
  TextEditingController _textController = TextEditingController();
  showDialog(
      context: context,
      builder: (context) => Form(
            key: _formKey,
            child: AlertDialog(
              title: Text("Edit Playlist"),
              content: TextFormField(
                controller: _textController,
                decoration: InputDecoration(labelText: "Playlist"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Playlist Name";
                  } // else if (checkPlaylistExists(value).isNotEmpty) {
                  //   return "Playlist already exists";
                  // }
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // addNewPlaylist(_textController.text.trim(), context);
                      final snackBar =
                          SnackBar(content: Text("Playlist Added"));
                    }
                  },
                  child: Text(
                    "Add",
                  ),
                ),
              ],
            ),
          ));
}
