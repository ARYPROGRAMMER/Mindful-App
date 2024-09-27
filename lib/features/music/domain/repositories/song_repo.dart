import 'package:mental_health/features/music/domain/entitites/song.dart';

abstract class SongRepository {
  Future<List<Song>> getAllSongs();
}
