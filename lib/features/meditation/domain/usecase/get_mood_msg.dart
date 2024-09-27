import 'package:mental_health/features/meditation/domain/entities/mood_msg.dart';
import 'package:mental_health/features/meditation/domain/repositories/meditation_repo.dart';

class GetMoodMessage {
  final MeditationRepository repository;

  GetMoodMessage({required this.repository});

  Future<MoodMessage> call(String mood) async {
    return await repository.getMoodMessage(mood);
  }
}
