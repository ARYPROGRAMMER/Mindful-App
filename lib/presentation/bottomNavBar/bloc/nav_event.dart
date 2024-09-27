abstract class NavEvent {}

class NavigateTo extends NavEvent {
  final int index;
  NavigateTo({required this.index});
}
