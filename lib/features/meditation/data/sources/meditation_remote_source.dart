import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mental_health/features/meditation/data/model/daily_quote_model.dart';
import 'package:mental_health/features/meditation/data/model/mood_msg_model.dart';
import 'package:mental_health/features/meditation/data/model/mood_data_model.dart';

abstract class MeditaionRemoteDataSource {
  Future<DailyQuoteModel> getDailyQuote();
  Future<MoodMessageModel> getMoodMessage(String mood);
  Future<MoodDataModel> getmoodData(String username);
}

class MeditationRemoteDataSourceImpl implements MeditaionRemoteDataSource {
  final http.Client client;
  MeditationRemoteDataSourceImpl({required this.client});

  @override
  Future<DailyQuoteModel> getDailyQuote() async {
    final response = await client.get(Uri.parse(
        'https://mindful-app-47s6.onrender.com/meditation/dailyQuotes'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      return DailyQuoteModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load daily quotes');
    }
  }

  @override
  Future<MoodMessageModel> getMoodMessage(String mood) async {
    final response = await client.get(Uri.parse(
        'https://mindful-app-47s6.onrender.com/meditation/myMood/$mood'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      return MoodMessageModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load mood quotes');
    }
  }

  @override
  Future<MoodDataModel> getmoodData(String username) async {
    final response = await client
        .get(Uri.parse('https://mindful-app-47s6.onrender.com/user/$username'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return MoodDataModel.fromJson(jsonResponse);
    } else {
      throw Exception("Failed to get data");
    }
  }
}
