import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
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
    final newPosition = currentPosition - const Duration(seconds: 10);
    _audioPlayer
        .seek(newPosition >= Duration.zero ? newPosition : Duration.zero);
  }

  void seekForward() {
    final currentPosition = _audioPlayer.position;
    final newPosition = currentPosition + const Duration(seconds: 10);
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Your Chill Song",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
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
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Container(
        padding: const EdgeInsets.only(top: 40, left: 35, right: 35),
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
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    fontSize: 18,
                                    color: Colors.grey.withOpacity(0.6)),
                          ),
                          Text(
                              (total.inSeconds.toDouble() / 60)
                                  .toStringAsFixed(2),
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      fontSize: 18,
                                      color: Colors.grey.withOpacity(0.6))),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CircularPercentIndicator(
                        arcType: ArcType.FULL,
                        backgroundColor: Colors.red,
                        progressColor: Colors.red,

                        // curve: Curves.easeInToLinear,
                        radius: MediaQuery.of(context).size.width / 2.7,
                        center: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.7 - 30),
                              boxShadow: [
                                BoxShadow(
                                  // spreadRadius: 20,
                                  blurRadius: 120,
                                  offset: const Offset(-3, 20),
                                  color:
                                      Colors.deepOrangeAccent.withOpacity(0.5),
                                )
                              ]),
                          width: MediaQuery.of(context).size.width * 0.7 - 40,
                          height: MediaQuery.of(context).size.width * 0.7 - 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width),
                            child: Image.network(
                              widget.song.imageid,
                              scale: 1,
                              // height: 200,
                              // width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        percent: position.inSeconds / total.inSeconds,
                        circularStrokeCap: CircularStrokeCap.round,
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
              height: 40,
            ),
            Text(
              widget.song.title,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 34, letterSpacing: 1),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "By : ${widget.song.author}",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(fontSize: 21, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 80,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                          size: 28,
                          CupertinoIcons.shuffle,
                          color: Colors.grey.withOpacity(0.5))),
                ),
                const SizedBox(
                  width: 18,
                ),
                Container(
                  child: IconButton(
                      onPressed: seekBackward,
                      icon: Icon(
                          size: 37,
                          Icons.skip_previous_sharp,
                          color: Colors.grey.withOpacity(0.5))),
                ),
                const SizedBox(
                  width: 2,
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
                          // margin: const EdgeInsets.all(8),
                          width: 50,
                          height: 50,
                          child: const CircularProgressIndicator(
                            color: DefaultColors.pink,
                          ),
                        );
                      } else if (!playing) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.redAccent.withOpacity(0.17),
                                    blurRadius: 5,
                                    spreadRadius: 10)
                              ]),
                          child: IconButton(
                              iconSize: 130,
                              onPressed: togglePlayPause,
                              icon: Icon(CupertinoIcons.play_circle_fill,
                                  color: Colors.redAccent.withOpacity(1))),
                        );
                      } else if (processingState != ProcessingState.completed) {
                        return Container(
                          child: IconButton(
                              iconSize: 110,
                              onPressed: togglePlayPause,
                              icon: Icon(
                                CupertinoIcons.pause_circle_fill,
                                color: Colors.redAccent.withOpacity(1),
                              )),
                        );
                      } else {
                        return Container(
                          child: IconButton(
                              iconSize: 110,
                              onPressed: seekRestart,
                              icon: Icon(
                                CupertinoIcons.restart,
                                color: Colors.redAccent.withOpacity(1),
                              )),
                        );
                      }
                    }),
                const SizedBox(
                  width: 2,
                ),
                Container(
                  child: IconButton(
                      onPressed: seekForward,
                      icon: Icon(
                        size: 26,
                        CupertinoIcons.playpause_fill,
                        color: Colors.grey.withOpacity(0.5),
                      )),
                ),
                const SizedBox(
                  width: 12,
                ),
                Container(
                  child: IconButton(
                      onPressed: toggleLoop,
                      icon: Icon(
                        size: 30,
                        isLooping
                            ? CupertinoIcons.repeat_1
                            : CupertinoIcons.repeat,
                        color: Colors.grey.withOpacity(0.5),
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
