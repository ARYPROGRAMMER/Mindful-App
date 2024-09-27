import 'package:mental_health/features/music/domain/entitites/song.dart';

class SongModel extends Song {
  SongModel({
    required String id,
    required String imageid,
    required String title,
    required String author,
    required String songlink,
  }) : super(
            id: id,
            imageid: imageid,
            title: title,
            author: author,
            songlink: songlink);

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
        id: json['id'] as String,
        imageid: json['imageid'] as String,
        title: json['title'] as String,
        author: json['author'] as String,
        songlink: json['songlink'] as String);
  }
}
