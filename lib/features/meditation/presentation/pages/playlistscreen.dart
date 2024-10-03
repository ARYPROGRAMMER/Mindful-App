import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
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
          elevation: 10,
          shadowColor: Colors.black,
          title: Text(
            'Chill Playlist',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocBuilder<SongBloc, SongState>(builder: (context, state) {
          if (state is SongLoading) {
            return Center(
              child: SizedBox(
                  height: 100,
                  child: LottieBuilder.network(
                      "https://lottie.host/65bd2e51-261e-4712-a5bd-38451aac4977/viHIqd4hxU.json")),
            );
          } else if (state is SongLoaded) {
            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                color: DefaultColors.white,
                child: ListView.separated(
                  itemCount: state.songs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(state.songs[index].imageid),
                      ),
                      trailing: const Icon(
                        color: Colors.black,
                        Icons.arrow_forward,
                        size: 15,
                      ),
                      title: Text(
                        state.songs[index].title,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontSize: 20),
                      ),
                      subtitle: Text(
                        state.songs[index].author,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(fontWeight: FontWeight.w500),
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
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 7,
                      thickness: 1,
                      color: Colors.black,
                    );
                  },
                ),
              ),
            );
          } else if (state is SongLoadFailure) {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                      height: 100,
                      child: LottieBuilder.network(
                          "https://lottie.host/fc2bc940-1d88-4ea2-8d5d-791e6480760e/4oA0NKLXn3.json")),
                  Text(state.message,
                      style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                      height: 100,
                      child: LottieBuilder.network(
                          "https://lottie.host/628ae316-ce58-4c02-a205-d29fe845a04a/DsXepW48Af.json")),
                  Text("No songs in database",
                      style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
            );
          }
        }));
  }
}
