import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mental_health/features/meditation/data/model/daily_quote_model.dart';
import 'package:mental_health/features/meditation/data/model/mood_msg_model.dart';

abstract class MeditaionRemoteDataSource {
  Future<DailyQuoteModel> getDailyQuote();
  Future<MoodMessageModel> getMoodMessage(String mood);
}

class MeditationRemoteDataSourceImpl implements MeditaionRemoteDataSource {
  final http.Client client;
  MeditationRemoteDataSourceImpl({required this.client});

  @override
  Future<DailyQuoteModel> getDailyQuote() async {
    final response = await client
        // .get(Uri.parse('http://10.0.3.218:6000/meditation/dailyQuotes'));
        .get(Uri.parse('https://mindful-app-47s6.onrender.com/meditation/dailyQuotes'));
    // await client.get(Uri.parse('http://192.168.29.6:6000/songs/all')); for android real device
    // await client.get(Uri.parse('http;//10.0.2.2:6000/songs/all')); for avd
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      // List finalRes = [];
      //
      // for (int i = 0; i < jsonResponse.length; i++) {
      //   finalRes.add(jsonResponse[i]['id']);
      // }

      return DailyQuoteModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load daily quotes');
    }
  }

  @override
  Future<MoodMessageModel> getMoodMessage(String mood) async {
    final response = await client
        // .get(Uri.parse('http://10.0.3.218:6000/meditation/myMood/$mood'));
        .get(Uri.parse('https://mindful-app-47s6.onrender.com/meditation/myMood/$mood'));
    // await client.get(Uri.parse('http://192.168.29.6:6000/songs/all')); for android real device
    // await client.get(Uri.parse('http;//10.0.2.2:6000/songs/all')); for avd
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      // List finalRes = [];
      //
      // for (int i = 0; i < jsonResponse.length; i++) {
      //   finalRes.add(jsonResponse[i]['id']);
      // }

      return MoodMessageModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load mood quotes');
    }
  }
}
