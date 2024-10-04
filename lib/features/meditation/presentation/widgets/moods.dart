import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MoodButton extends StatelessWidget {
  final String label;
  final String path;
  // final Color color;
  final VoidCallback onTap;
  const MoodButton(
      {super.key,
      required this.label,
      required this.path,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: LottieBuilder.network(path),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall,
          )
        ],
      ),
    );
  }
}
