import 'package:mental_health/features/meditation/domain/entities/mood_data.dart';

abstract class MoodDataState {}

class MoodDataInitial extends MoodDataState {}

class MoodDataLoading extends MoodDataState {}

class MoodDataLoaded extends MoodDataState {
  final MoodData moodDatainfo;

  MoodDataLoaded({required this.moodDatainfo});
}

class MoodDataError extends MoodDataState {
  final String message;

  MoodDataError({required this.message});
}
