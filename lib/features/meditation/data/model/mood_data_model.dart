import 'dart:convert';

import 'package:mental_health/features/meditation/domain/entities/mood_data.dart';

class MoodDataModel extends MoodData {
  MoodDataModel({
    required String happy,
    required String neutral,
    required String sad,
    required String calm,
    required String relax,
    required String focus,
  }) : super(
    happy: happy,
    neutral: neutral,
    sad: sad,
    calm: calm,
    relax: relax,
    focus: focus
  );

  factory MoodDataModel.fromJson(json) {
    final data = jsonDecode(json);
    return MoodDataModel(
       happy: data['happy'],
       sad: data['sad'],
       neutral: data['neutral'],
       calm: data['calm'],
       relax: data['relax'],
       focus: data['focus'],
    );
  }
}
