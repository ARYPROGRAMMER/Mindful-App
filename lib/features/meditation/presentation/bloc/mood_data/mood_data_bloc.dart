import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/features/meditation/domain/usecase/get_mood_data.dart';
import 'package:mental_health/features/meditation/presentation/bloc/mood_data/mood_data_event.dart';
import 'package:mental_health/features/meditation/presentation/bloc/mood_data/mood_data_state.dart';

class MoodDataBloc extends Bloc<MoodDataEvent, MoodDataState> {
  final GetMoodData getmoodData;

  MoodDataBloc({required this.getmoodData}) : super(MoodDataInitial()) {
    on<FetchMoodData>((event, emit) async {
      emit(MoodDataLoading());
      try {
        final moodDatainfo = await getmoodData(event.username);
        emit(MoodDataLoaded(moodDatainfo: moodDatainfo));
      } catch (e) {
        emit(MoodDataError(message: e.toString()));
      }
    });
  }
}
