import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:mental_health/features/music/data/models/SongModel.dart';
import 'package:mental_health/features/music/domain/entitites/song.dart';

abstract class SongRemoteDataSource {
  Future<List<Song>> getAllSongs();
}

class SongRemoteDataSourceImpl implements SongRemoteDataSource {
  final http.Client client;

  SongRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Song>> getAllSongs() async {
    final response = await client
        .get(Uri.parse('https://mindful-app-47s6.onrender.com/songs/all'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List finalRes = [];

      for (int i = 0; i < jsonResponse.length; i++) {
        finalRes.add(jsonResponse[i]['id']);
      }

      return finalRes.map((song) => SongModel.fromJson(song)).toList();
    } else {
      throw Exception('Failed to load songs');
    }
  }
}
