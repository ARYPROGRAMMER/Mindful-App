import 'package:get_it/get_it.dart';
import 'package:mental_health/features/auth/data/repositories/auth/auth_repository_impl.dart';
import 'package:mental_health/features/auth/data/sources/auth/auth_firebase_service.dart';
import 'package:mental_health/features/auth/domain/repositories/auth/auth.dart';
import 'package:mental_health/features/auth/domain/usecases/auth/signin.dart';
import 'package:mental_health/features/auth/domain/usecases/auth/signup.dart';
import 'package:mental_health/features/meditation/data/repositories/meditaion_repo_impl.dart';
import 'package:mental_health/features/meditation/data/sources/meditation_remote_source.dart';
import 'package:mental_health/features/meditation/domain/repositories/meditation_repo.dart';
import 'package:mental_health/features/meditation/domain/usecase/get_daily_quote.dart';
import 'package:mental_health/features/meditation/domain/usecase/get_mood_data.dart';
import 'package:mental_health/features/meditation/domain/usecase/get_mood_msg.dart';
import 'package:mental_health/features/meditation/presentation/bloc/dailyQuote/daily_quote_bloc.dart';
import 'package:mental_health/features/meditation/presentation/bloc/mood_message/mood_message_bloc.dart';
import 'package:mental_health/features/music/data/repositories/song_repo_impl.dart';
import 'package:mental_health/features/music/data/sources/song_datasource.dart';
import 'package:mental_health/features/music/domain/repositories/song_repo.dart';
import 'package:mental_health/features/music/domain/usecase/get_all_song.dart';
import 'package:mental_health/features/music/presentation/bloc/song_bloc.dart';
import 'package:mental_health/features/meditation/presentation/bloc/mood_data/mood_data_bloc.dart';
import 'package:mental_health/features/meditation/presentation/bloc/mood_data/mood_data_event.dart';
import 'package:mental_health/features/meditation/presentation/bloc/mood_data/mood_data_state.dart';

import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //blocs
  sl.registerFactory(() => DailyQuoteBloc(getDailyQuote: sl()));
  sl.registerFactory(() => MoodMessageBloc(getMoodMessage: sl()));
  sl.registerFactory(() => SongBloc(getAllSongs: sl()));
  sl.registerFactory(() => MoodDataBloc(getmoodData: sl()));

  //usecase
  sl.registerLazySingleton(() => GetDailyQuote(repository: sl()));
  sl.registerLazySingleton(() => GetMoodMessage(repository: sl()));
  sl.registerLazySingleton(() => GetAllSongs(repository: sl()));
  sl.registerLazySingleton(() => GetMoodData(repository: sl()));

  //repos
  sl.registerLazySingleton<MeditationRepository>(
      () => MeditationRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<SongRepository>(
      () => SongRepositoryImpl(remoteDataSource: sl()));

  //sources
  sl.registerLazySingleton<MeditaionRemoteDataSource>(
      () => MeditationRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<SongRemoteDataSource>(
      () => SongRemoteDataSourceImpl(client: sl()));

  //back to blocs
  sl.registerLazySingleton(() => http.Client());

  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
}
