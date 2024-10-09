abstract class MoodDataEvent {}

class FetchMoodData extends MoodDataEvent {
  final String username;

  FetchMoodData(this.username);
}
