import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mental_health/core/theme.dart';
import 'package:mental_health/features/auth/domain/entities/auth/googleapisignin.dart';
import 'package:mental_health/features/meditation/presentation/bloc/dailyQuote/daily_quote_bloc.dart';
import 'package:mental_health/features/meditation/presentation/bloc/dailyQuote/daily_quote_event.dart';
import 'package:mental_health/features/meditation/presentation/bloc/mood_data/mood_data_bloc.dart';
import 'package:mental_health/features/meditation/presentation/bloc/mood_data/mood_data_event.dart';
import 'package:mental_health/features/meditation/presentation/bloc/mood_message/mood_message_bloc.dart';
import 'package:mental_health/features/music/presentation/bloc/song_bloc.dart';
import 'package:mental_health/features/music/presentation/bloc/song_event.dart';
import 'package:mental_health/firebase_options.dart';
import 'package:mental_health/presentation/bottomNavBar/bloc/nav_bloc.dart';
import 'package:mental_health/presentation/homePage/home_page.dart';
import 'package:mental_health/presentation/onboarding/onboarding.dart';
import 'injections.dart' as di;

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('lastlogin');
  await Hive.openBox('firstime');
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
    final mybox = Hive.box('lastlogin');
    final first = Hive.box('firstime');
    final idval;
    first.put('firsttime', 'false');
    bool google = mybox.get('google').toString() == 'true';
    if (google == true) {
      idval = "aryasingh8405@gmail.com-google"; //temp
    } else {
      idval = FirebaseAuth.instance.currentUser?.email.toString();
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavBloc()),
        BlocProvider(create: (context) => di.sl<SongBloc>()..add(FetchSongs())),
        BlocProvider(
            create: (context) =>
                di.sl<DailyQuoteBloc>()..add(FetchDailyQuote())),
        BlocProvider(create: (context) => di.sl<MoodMessageBloc>()),
        BlocProvider(create: (context) => di.sl<MoodDataBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mental Health',
        theme: AppTheme.lightTheme,
        home: (FirebaseAuth.instance.currentUser == null)
            ? google
                ? const inPage()
                : const Onboarding()
            : HomePage(),
      ),
    );
  }
}

class inPage extends StatefulWidget {
  const inPage({super.key});

  @override
  State<inPage> createState() => _inPageState();
}

class _inPageState extends State<inPage> {
  Future signIn() async {
    final user = await GoogleSignInApi.login();
    final myboxx = Hive.box('lastlogin');
    final first = Hive.box('firstime');
    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Failure")));
    } else {
      myboxx.put('google', 'true');
      first.put("firsttime", 'false');
      String? value = GoogleSignInApi.details()?.email;

      try {
        context.read<MoodDataBloc>().add(FetchMoodData("${value}-google"));
      } catch (error) {}
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
          (route) => false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    signIn();
    Future.delayed(const Duration(seconds: 2));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.google,
                  color: Colors.red,
                  size: 30,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Signing In...",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )
              ],
            )),
      ),
    );
  }
}
