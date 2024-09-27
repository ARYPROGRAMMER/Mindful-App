import 'package:mental_health/features/music/data/sources/song_datasource.dart';
import 'package:mental_health/features/music/domain/entitites/song.dart';
import 'package:mental_health/features/music/domain/repositories/song_repo.dart';

class SongRepositoryImpl implements SongRepository {
  final SongRemoteDataSource remoteDataSource;

  SongRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Song>> getAllSongs() async {
    final songModel = await remoteDataSource.getAllSongs();
    return songModel;
  }
}
