import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:quraanproject/model/data_model.dart';

ValueNotifier<List<PlayListModel>> PlayListNotifier=ValueNotifier([]);
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