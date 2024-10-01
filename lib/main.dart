import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/core/theme.dart';

import 'package:mental_health/features/meditation/presentation/bloc/dailyQuote/daily_quote_bloc.dart';

import 'package:mental_health/features/meditation/presentation/bloc/dailyQuote/daily_quote_event.dart';
import 'package:mental_health/features/meditation/presentation/bloc/mood_message/mood_message_bloc.dart';

import 'package:mental_health/features/music/presentation/bloc/song_bloc.dart';
import 'package:mental_health/features/music/presentation/bloc/song_event.dart';
import 'package:mental_health/firebase_options.dart';
import 'package:mental_health/presentation/bottomNavBar/bloc/nav_bloc.dart';
import 'package:mental_health/presentation/homePage/home_page.dart';

import 'package:mental_health/presentation/onboarding/onboarding.dart';
import 'injections.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> user;

  @override
  void initState() {
    user = FirebaseAuth.instance.authStateChanges().listen((user) {});

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    user.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavBloc()),
        BlocProvider(create: (context) => di.sl<SongBloc>()..add(FetchSongs())),
        BlocProvider(
            create: (context) =>
                di.sl<DailyQuoteBloc>()..add(FetchDailyQuote())),
        BlocProvider(create: (context) => di.sl<MoodMessageBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mental Health',
        theme: AppTheme.lightTheme,
        home: FirebaseAuth.instance.currentUser == null
            ? const Onboarding()
            : HomePage(),
      ),
    );
  }
}
