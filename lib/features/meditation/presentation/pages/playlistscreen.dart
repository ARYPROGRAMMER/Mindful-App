import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/core/theme.dart';
import 'package:mental_health/features/music/data/sources/song_datasource.dart';
import 'package:mental_health/features/music/domain/entitites/song.dart';
import 'package:mental_health/features/music/presentation/bloc/song_bloc.dart';
import 'package:mental_health/features/music/presentation/pages/music_player_screen.dart';

import '../../../music/presentation/bloc/song_state.dart';

class Playlistscreen extends StatefulWidget {
  Playlistscreen({super.key});

  @override
  State<Playlistscreen> createState() => _PlaylistscreenState();
}

class _PlaylistscreenState extends State<Playlistscreen> {
  // final List<Map<String, String>> songs = [
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: DefaultColors.white,
          centerTitle: false,
          elevation: 5,
          shadowColor: Colors.black,
          title: Text(
            'Chill Playlist',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        body: BlocBuilder<SongBloc, SongState>(builder: (context, state) {
          if (state is SongLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is SongLoaded) {
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                color: DefaultColors.white,
                child: ListView.builder(
                    itemCount: state.songs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(state.songs[index].imageid),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward,
                          size: 15,
                        ),
                        title: Text(
                          state.songs[index].title,
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 20),
                        ),
                        subtitle: Text(
                          state.songs[index].author,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        onTap: () {
                          //
                          // var x = SongRemoteDataSourceImpl(client: http.Client());
                          // x.getAllSongs();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MusicPlayerScreen(
                                        song: state.songs[index],
                                      )));
                        },
                      );
                    }),
              ),
            );
          } else if (state is SongLoadFailure) {
            return Center(
              child: Text(state.message,
                  style: Theme.of(context).textTheme.labelSmall),
            );
          } else {
            return Center(
              child: Text("No songs in database",
                  style: Theme.of(context).textTheme.labelSmall),
            );
          }
        }));
  }
}
