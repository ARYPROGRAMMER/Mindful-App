import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mental_health/core/theme.dart';
import 'package:mental_health/features/music/domain/entitites/song.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MusicPlayerScreen extends StatefulWidget {
  final Song song;

  const MusicPlayerScreen({super.key, required this.song});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool isLooping = false;

  @override
  void initState() {
    _audioPlayer = AudioPlayer();
    _audioPlayer.setUrl(widget.song.songlink);
    togglePlayPause();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void togglePlayPause() {
    if (_audioPlayer.playing) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }

  void seekBackward() {
    final currentPosition = _audioPlayer.position;
    final newPosition = currentPosition - Duration(seconds: 10);
    _audioPlayer
        .seek(newPosition >= Duration.zero ? newPosition : Duration.zero);
  }

  void seekForward() {
    final currentPosition = _audioPlayer.position;
    final newPosition = currentPosition + Duration(seconds: 10);
    _audioPlayer
        .seek(newPosition >= Duration.zero ? newPosition : Duration.zero);
  }

  void seekRestart() {
    _audioPlayer.seek(Duration.zero);
  }

  void toggleLoop() {
    setState(() {
      isLooping = !isLooping;
      _audioPlayer.setLoopMode(isLooping ? LoopMode.one : LoopMode.off);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Your Chill Song"),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset(
            'assets/down_arrow.png',
          ),
        ),
        actions: [
          Image.asset("assets/transcript_icon.png"),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      backgroundColor: DefaultColors.white,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            //
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(20),
            //   child: Image.network(
            //     widget.song.imageid,
            //     height: 300,
            //     width: double.infinity,
            //     fit: BoxFit.cover,
            //   ),
            // ),

            // const Spacer(),
            StreamBuilder<Duration>(
                stream: _audioPlayer.positionStream,
                builder: (context, snapshot) {
                  final position = snapshot.data ?? Duration.zero;
                  final total = _audioPlayer.duration ?? Duration.zero;
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            (position.inSeconds.toDouble() / 60)
                                .toStringAsFixed(2),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                              (total.inSeconds.toDouble() / 60)
                                  .toStringAsFixed(2),
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                      CircularPercentIndicator(
                        arcType: ArcType.FULL,
                        backgroundColor: DefaultColors.lightpink,
                        progressColor: Colors.blue,
                        curve: Curves.easeInToLinear,
                        radius: MediaQuery.of(context).size.width / 5,
                        center: Container(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.width / 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width / 2),
                            child: Image.network(
                              widget.song.imageid,
                              scale: 0.1,
                              // height: 200,
                              // width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        percent: position.inSeconds / total.inSeconds,
                      ),
                    ],
                  );

                  // return ProgressBar(
                  //   timeLabelLocation: TimeLabelLocation.below,
                  //   timeLabelTextStyle: Theme.of(context).textTheme.labelSmall,
                  //   progress: position,
                  //   total: total,
                  //   baseBarColor: DefaultColors.lightpink,
                  //   thumbColor: DefaultColors.pink,
                  //   onSeek: (duration) {
                  //     _audioPlayer.seek(duration);
                  //   },
                  // );
                }),

            const SizedBox(
              height: 100,
            ),
            Text(
              widget.song.title,
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
            Text(
              "By : ${widget.song.author}",
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.shuffle,
                        color: DefaultColors.pink,
                      )),
                ),
                Container(
                  child: IconButton(
                      onPressed: seekBackward,
                      icon: const Icon(
                        Icons.skip_previous,
                        color: DefaultColors.pink,
                      )),
                ),
                StreamBuilder(
                    stream: _audioPlayer.playerStateStream,
                    builder: (context, snapshot) {
                      final playerState = snapshot.data;
                      final processingState =
                          playerState?.processingState ?? ProcessingState.idle;
                      var playing = playerState?.playing ?? false;
                      if (processingState == ProcessingState.loading ||
                          processingState == ProcessingState.buffering) {
                        return Container(
                          margin: EdgeInsets.all(8),
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            color: DefaultColors.pink,
                          ),
                        );
                      } else if (!playing) {
                        return Container(
                          child: IconButton(
                              iconSize: 80,
                              onPressed: togglePlayPause,
                              icon: const Icon(
                                Icons.play_circle_fill,
                                color: DefaultColors.pink,
                              )),
                        );
                      } else if (processingState != ProcessingState.completed) {
                        return Container(
                          child: IconButton(
                              iconSize: 80,
                              onPressed: togglePlayPause,
                              icon: const Icon(
                                Icons.pause_circle,
                                color: DefaultColors.pink,
                              )),
                        );
                      } else {
                        return Container(
                          child: IconButton(
                              iconSize: 80,
                              onPressed: seekRestart,
                              icon: const Icon(
                                Icons.replay,
                                color: DefaultColors.pink,
                              )),
                        );
                      }
                    }),
                Container(
                  child: IconButton(
                      onPressed: seekForward,
                      icon: const Icon(
                        Icons.skip_next,
                        color: DefaultColors.pink,
                      )),
                ),
                Container(
                  child: IconButton(
                      onPressed: toggleLoop,
                      icon: Icon(
                        isLooping ? Icons.repeat_one : Icons.repeat,
                        color: DefaultColors.pink,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
