abstract class NavState {}

class NavChanged extends NavState {
  final int index;
  NavChanged({required this.index});
}
