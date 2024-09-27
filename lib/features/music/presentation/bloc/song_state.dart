import 'package:mental_health/features/music/domain/entitites/song.dart';

abstract class SongState {}

class SongInitial extends SongState {}

class SongLoading extends SongState {}

class SongLoaded extends SongState {
  final List<Song> songs;

  SongLoaded({required this.songs});
}

class SongLoadFailure extends SongState {
  final String message;

  SongLoadFailure({required this.message});
}
