import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 0)
class PlayListModel {
  @HiveField(0)
  late String name;
  PlayListModel({required this.name});
}

@HiveType(typeId: 1)
class PlaylistSongs {
  @HiveField(0)
  late String song;
  @HiveField(1)
  late String playListName;
  @HiveField(2)
  late int chapterNo;
  PlaylistSongs({
    required this.song,
    required this.playListName,
    required this.chapterNo,
  });
}

@HiveType(typeId: 2)
class Favourites{

  @HiveField(0)
  int favNo;
  
  Favourites({required this.favNo});
}
