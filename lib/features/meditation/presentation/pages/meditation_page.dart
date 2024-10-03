import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mental_health/features/meditation/presentation/bloc/dailyQuote/daily_quote_bloc.dart';
import 'package:mental_health/features/meditation/presentation/bloc/dailyQuote/daily_quote_event.dart';
import 'package:mental_health/features/meditation/presentation/bloc/dailyQuote/daily_quote_state.dart';
import 'package:mental_health/features/meditation/presentation/bloc/mood_message/mood_message_bloc.dart';
import 'package:mental_health/features/meditation/presentation/bloc/mood_message/mood_message_event.dart';
import 'package:mental_health/features/meditation/presentation/bloc/mood_message/mood_message_state.dart';
import 'package:mental_health/features/meditation/presentation/widgets/moods.dart';
import 'package:mental_health/features/meditation/presentation/widgets/task_card.dart';
import 'package:mental_health/presentation/chat_screen/chat_with_ai.dart';

import '../../../../core/theme.dart';

class MeditationPage extends StatelessWidget {
  const MeditationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // String? imageSource = main?.photoURL;
    // String? name = main?.displayName;
    User? user = FirebaseAuth.instance.currentUser;
    user?.reload();

    return Scaffold(
      backgroundColor: DefaultColors.white,
      appBar: AppBar(
        elevation: 0,
        leading: Image.asset(
          'assets/menu_burger.png',
        ),
        actions: [
          CircleAvatar(
            backgroundImage: user!.photoURL == null
                ? const AssetImage('assets/profile.png')
                : NetworkImage(user.photoURL!),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: Text(
                      "Welcome Back, ${user.displayName}",
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const ChatScreen()));
                        },
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: LottieBuilder.network(
                              "https://lottie.host/7f8fdd94-95c4-4a11-90bb-edc15af41005/jVxlzL8zAW.json"),
                          // decoration: const BoxDecoration(
                          //     image: DecorationImage(
                          //         image: AssetImage('assets/bot_ai.png'))),
                        )),
                  )
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                "How are you feeling today ?",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MoodButton(
                      label: "Happy",
                      image: 'assets/happy.png',
                      color: DefaultColors.pink,
                      onTap: () {
                        context
                            .read<MoodMessageBloc>()
                            .add(FetchMoodMessage('happy'));
                      }),
                  MoodButton(
                      label: "Calm",
                      image: 'assets/calm.png',
                      color: DefaultColors.purple,
                      onTap: () {
                        context
                            .read<MoodMessageBloc>()
                            .add(FetchMoodMessage('calm'));
                      }),
                  MoodButton(
                      label: "Relax",
                      image: 'assets/relax.png',
                      color: DefaultColors.orange,
                      onTap: () {
                        context
                            .read<MoodMessageBloc>()
                            .add(FetchMoodMessage('relax'));
                      }),
                  MoodButton(
                      label: "Focus",
                      image: 'assets/focus.png',
                      color: DefaultColors.lightteal,
                      onTap: () {
                        context
                            .read<MoodMessageBloc>()
                            .add(FetchMoodMessage('focus'));
                      }),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<DailyQuoteBloc, DailyQuoteState>(
                  builder: (context, state) {
                if (state is DailyQuoteLoading) {
                  return Center(
                    child: SizedBox(
                        height: 100,
                        child: LottieBuilder.network(
                            "https://lottie.host/65bd2e51-261e-4712-a5bd-38451aac4977/viHIqd4hxU.json")),
                  );
                } else if (state is DailyQuoteLoaded) {
                  final int h = DateTime.now().hour;

                  if (0 <= h && h <= 12) {
                    return TaskCard(
                        title: "A Very Good Morning",
                        description: state.dailyQuote.morningQuote,
                        color: DefaultColors.task1);
                  } else if (12 <= h && h <= 17) {
                    return TaskCard(
                        title: "Good Afternoon",
                        description: state.dailyQuote.noonQuote,
                        color: DefaultColors.task2);
                  } else {
                    return TaskCard(
                        title: "Good Evening",
                        description: state.dailyQuote.eveningQuote,
                        color: DefaultColors.task3);
                  }
                } else if (state is DailyQuoteError) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                            height: 100,
                            child: LottieBuilder.network(
                                "https://lottie.host/628ae316-ce58-4c02-a205-d29fe845a04a/DsXepW48Af.json")),
                        Text(
                            "Please Check Server Connection and Refresh (Errorx01)",
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
                                "https://lottie.host/fc2bc940-1d88-4ea2-8d5d-791e6480760e/4oA0NKLXn3.json")),
                        Text("Please Refresh (Errorx02)",
                            style: Theme.of(context).textTheme.labelSmall),
                      ],
                    ),
                  );
                }
              }),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today's status",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        context.read<DailyQuoteBloc>().add(FetchDailyQuote());
                      },
                      icon: const Icon(
                        Icons.refresh_rounded,
                        color: DefaultColors.orange,
                      ))
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey.shade100.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                          border: const Border(
                              bottom: BorderSide(color: Colors.black),
                              top: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black))),
                      height: 200,
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.apple,
                                  size: 60,
                                ),
                                // SizedBox(width: MediaQuery.of(context).size.width/60),

                                Text(
                                  "Food",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 36),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "1185 of 2400 cals consumed",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                            //progres bar
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey.shade100.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                          border: const Border(
                              bottom: BorderSide(color: Colors.black),
                              top: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black))),
                      height: 200,
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.water_drop_outlined,
                                  size: 50,
                                ),
                                // SizedBox(width: MediaQuery.of(context).size.width/60),

                                Text(
                                  "Water",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 36),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "You drank 4 glasses of water out of 6",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                            //progres bar
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.lightBlue.shade100.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                    border: const Border(
                        bottom: BorderSide(color: Colors.black),
                        top: BorderSide(color: Colors.black),
                        left: BorderSide(color: Colors.black),
                        right: BorderSide(color: Colors.black))),
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.face,
                            size: 30,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Overall Health Analysis",
                            style: TextStyle(color: Colors.black, fontSize: 30),
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "The total overall mood is happy 75% times",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                    //graph
                  ],
                ),
              ),
              BlocBuilder<MoodMessageBloc, MoodMessageState>(
                builder: (context, state) {
                  if (state is MoodMessageLoaded) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(
                                  'Mood Advice for You',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                content: Text(state.moodMessage.text,
                                    style:
                                        Theme.of(context).textTheme.labelSmall),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        context
                                            .read<MoodMessageBloc>()
                                            .add(ResetMoodMessage());
                                      },
                                      child: const Text("ok"))
                                ],
                              ));
                    });
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
