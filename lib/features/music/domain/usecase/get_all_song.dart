import 'package:mental_health/features/music/domain/entitites/song.dart';
import 'package:mental_health/features/music/domain/repositories/song_repo.dart';

class GetAllSongs {
  final SongRepository repository;

  GetAllSongs({required this.repository});

  Future<List<Song>> call() async {
    return await repository.getAllSongs();
  }
}
