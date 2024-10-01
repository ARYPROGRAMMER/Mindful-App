import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/features/meditation/presentation/pages/meditation_page.dart';
import 'package:mental_health/features/meditation/presentation/pages/playlistscreen.dart';
import 'package:mental_health/features/meditation/presentation/pages/settingscreen.dart';
import 'package:mental_health/presentation/Face_Emotion_Recognition/fer2013.dart';
import 'package:mental_health/presentation/bottomNavBar/bloc/nav_bloc.dart';
import 'package:mental_health/presentation/bottomNavBar/bloc/nav_state.dart';
import 'package:mental_health/presentation/bottomNavBar/widgets/bottomNavBar.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Widget> pages = [
    MeditationPage(),
    FaceEmotionDetector(),
    Playlistscreen(),
    const SettingScreen(),
  ];

  BottomNavigationBarItem createItem(
      {required String assetName,
      required bool isActive,
      bool settings = false,
      required BuildContext context}) {
    return BottomNavigationBarItem(
        icon: Image.asset(
          assetName,
          color: isActive
              ? Theme.of(context).focusColor
              : Theme.of(context).primaryColor,
          height: settings ? 30 : 45,
        ),
        label: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavBloc, NavState>(
        builder: (context, state) {
          if (state is NavChanged) {
            return pages[state.index];
          }
          return pages[0];
        },
      ),
      bottomNavigationBar:
          BlocBuilder<NavBloc, NavState>(builder: (context, state) {
        int currentIndex = 0;
        if (state is NavChanged) {
          currentIndex = state.index;
        }
        final List<BottomNavigationBarItem> bottomNavItems = [
          createItem(
              assetName: "assets/menu_home.png",
              isActive: currentIndex == 0,
              context: context),
          createItem(
            assetName: 'assets/ais.png',
            isActive: currentIndex == 1,
            context: context,
          ),
          createItem(
              assetName: 'assets/menu_songs.png',
              isActive: currentIndex == 2,
              context: context),
          createItem(
              assetName: 'assets/settings.png',
              isActive: currentIndex == 3,
              context: context,
              settings: true),
        ];

        return Bottomnavbar(items: bottomNavItems, currentIndex: currentIndex);
      }),
    );
  }
}
