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
      onDoubleTap: () {},
      onTap: onTap,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              height: 60,
              child: LottieBuilder.network(path),
            ),
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
