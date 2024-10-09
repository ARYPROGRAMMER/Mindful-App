import 'package:mental_health/features/meditation/data/sources/meditation_remote_source.dart';
import 'package:mental_health/features/meditation/domain/entities/dailyQuotes.dart';
import 'package:mental_health/features/meditation/domain/entities/mood_msg.dart';
import 'package:mental_health/features/meditation/domain/entities/mood_data.dart';
import 'package:mental_health/features/meditation/domain/repositories/meditation_repo.dart';

class MeditationRepoImpl implements MeditationRepository {
  final MeditaionRemoteDataSource remoteDataSource;

  MeditationRepoImpl({required this.remoteDataSource});

  @override
  Future<DailyQuote> getDailyQuote() async {
    return await remoteDataSource.getDailyQuote();
  }

  @override
  Future<MoodMessage> getMoodMessage(String mood) async {
    return await remoteDataSource.getMoodMessage(mood);
  }

  @override
  Future<MoodData> getmoodData(String username) async {
    return await remoteDataSource.getmoodData(username);
  }
}
