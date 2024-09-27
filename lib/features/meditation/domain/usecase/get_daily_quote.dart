import 'package:mental_health/features/meditation/domain/entities/dailyQuotes.dart';
import 'package:mental_health/features/meditation/domain/repositories/meditation_repo.dart';

class GetDailyQuote {
  final MeditationRepository repository;

  GetDailyQuote({required this.repository});
  Future<DailyQuote> call() async {
    return repository.getDailyQuote();
  }
}
