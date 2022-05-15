import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:quraanproject/main.dart';
import 'package:quraanproject/model/data_model.dart';


ValueNotifier<List<PlayListModel>> PlayListNotifier=ValueNotifier([]);
ValueNotifier<List<PlayListModel>> favListNotifier=ValueNotifier([]);

Future<void> addPlaylist(PlayListModel value) async{


final playlistDB =await Hive.openBox<PlayListModel>('playlist_db');

await  playlistDB.add(value);

 PlayListNotifier.value.add(value);

PlayListNotifier.notifyListeners();

print(value.toString());

} 
Future <void>getAllPlaylist() async{
  final playlistDB =await Hive.openBox<PlayListModel>('playlist_db');
  PlayListNotifier.value.clear();
  PlayListNotifier.value.addAll(playlistDB.values);
  PlayListNotifier.notifyListeners();

}
Future<void>getAllPlaylistSongs()async{

}
  deletePlaylist(String playSongId) async {
    final playlistDB = await Hive.openBox<PlayListModel>('playlist_db');
    final Map<dynamic, PlayListModel> deliveriesMap = playlistDB.toMap();
    dynamic desiredKey;
    deliveriesMap.forEach((key, value) {
      if (value.name == playSongId) desiredKey = key;
    });
    playlistDB.delete(desiredKey);
    PlayListNotifier.value.clear();
    PlayListNotifier.value.addAll(playlistDB.values);
    PlayListNotifier.notifyListeners();
  }


editPlaylist({required oldValue, required newValue, required index,}) async{
   final playlistDB = await Hive.openBox<PlayListModel>('playlist_db');
    final Map<dynamic, PlayListModel> deliveriesMap = playlistDB.toMap();
    dynamic desiredKey;
    deliveriesMap.forEach((key, value) {
      if (value.name == oldValue) desiredKey = key;
    });
    PlayListModel playModel = PlayListModel(name: newValue);
    playlistDB.put(desiredKey, playModel);

    final Map<dynamic, PlaylistSongs> playSongMap = playSongBox.toMap();
    playSongMap.forEach((key, value) {
      if (value.playListName == oldValue) 
      desiredKey = key;
      PlaylistSongs playSongsModel = PlaylistSongs(playListName: newValue, chapterNo: index, song: '');
      playSongBox.put(desiredKey, playSongsModel);
    });

    
    
}