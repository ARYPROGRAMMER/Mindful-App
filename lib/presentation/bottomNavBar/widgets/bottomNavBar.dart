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
    return BottomNavigationBar(
      items: items,
      currentIndex: currentIndex,
      onTap: (index) {
        context.read<NavBloc>().add(NavigateTo(index: index));
      },
    );
  }
}
