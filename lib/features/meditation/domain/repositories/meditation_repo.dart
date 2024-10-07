import 'package:mental_health/features/meditation/domain/entities/dailyQuotes.dart';
import 'package:mental_health/features/meditation/domain/entities/mood_data.dart';
import 'package:mental_health/features/meditation/domain/entities/mood_msg.dart';

abstract class MeditationRepository {
  Future<DailyQuote> getDailyQuote();
  Future<MoodMessage> getMoodMessage(String mood);
  Future<MoodData> getmoodData(String username);
}
