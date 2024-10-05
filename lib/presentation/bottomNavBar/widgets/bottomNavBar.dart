import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/presentation/bottomNavBar/bloc/nav_bloc.dart';
import 'package:mental_health/presentation/bottomNavBar/bloc/nav_event.dart';

class Bottomnavbar extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  const Bottomnavbar(
      {super.key, required this.items, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      color: Colors.transparent,
      padding: const EdgeInsets.only(top: 16, bottom: 20, right: 20, left: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BottomNavigationBar(
          items: items,
          currentIndex: currentIndex,
          onTap: (index) {
            context.read<NavBloc>().add(NavigateTo(index: index));
          },
        ),
      ),
    );
  }
}
