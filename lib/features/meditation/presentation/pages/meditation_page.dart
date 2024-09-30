import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Scaffold(
      backgroundColor: DefaultColors.white,
      appBar: AppBar(
        elevation: 0,
        leading: Image.asset(
          'assets/menu_burger.png',
        ),
        actions: [
          const CircleAvatar(
            backgroundImage: AssetImage("assets/profile.png"),
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
                  Text(
                    "Welcome Back, Arya",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                        onTap : (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const ChatScreen()));
                        },
                      child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/bot_ai.png'))),
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
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today\'s Task",
                    style: Theme.of(context).textTheme.titleMedium,
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
              BlocBuilder<DailyQuoteBloc, DailyQuoteState>(
                  builder: (context, state) {
                if (state is DailyQuoteLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state is DailyQuoteLoaded) {
                  return Column(
                    children: [
                      TaskCard(
                          title: "Morning",
                          description: state.dailyQuote.morningQuote,
                          color: DefaultColors.task1),
                      const SizedBox(
                        height: 16,
                      ),
                      TaskCard(
                          title: "Noon",
                          description: state.dailyQuote.noonQuote,
                          color: DefaultColors.task2),
                      const SizedBox(
                        height: 16,
                      ),
                      TaskCard(
                          title: "Evening",
                          description: state.dailyQuote.eveningQuote,
                          color: DefaultColors.task3),
                    ],
                  );
                } else if (state is DailyQuoteError) {
                  return Center(
                    child: Text(
                        "Please Check Server Connection and Refresh (Errorx01)",
                        style: Theme.of(context).textTheme.labelSmall),
                  );
                } else {
                  return Center(
                    child: Text("Please Refresh (Errorx02)",
                        style: Theme.of(context).textTheme.labelSmall),
                  );
                }
              }),
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
