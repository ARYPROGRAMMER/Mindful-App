import 'package:mental_health/features/meditation/domain/entities/mood_data.dart';
import 'package:mental_health/features/meditation/domain/repositories/meditation_repo.dart';

class GetMoodData {
  final MeditationRepository repository;

  GetMoodData({required this.repository});

  Future<MoodData> call(String username) async {
    return await repository.getmoodData(username);
  }
}
