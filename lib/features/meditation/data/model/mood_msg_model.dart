import 'package:mental_health/features/meditation/domain/entities/mood_msg.dart';

class MoodMessageModel extends MoodMessage {
  MoodMessageModel({required String text}) : super(text: text);
  factory MoodMessageModel.fromJson(String json) {
    return MoodMessageModel(text: json);
  }
}
