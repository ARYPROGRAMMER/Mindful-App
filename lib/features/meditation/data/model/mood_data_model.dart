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
            focus: focus);

  factory MoodDataModel.fromJson(Map<String, dynamic> json) {
    return MoodDataModel(
        happy: json['happy'].toString(),
        sad: json['sad'].toString(),
        neutral: json['neutral'].toString(),
        calm: json['calm'].toString(),
        relax: json['relax'].toString(),
        focus: json['focus'].toString());
  }
}
