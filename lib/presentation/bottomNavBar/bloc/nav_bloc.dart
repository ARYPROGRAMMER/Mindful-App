import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/presentation/bottomNavBar/bloc/nav_event.dart';
import 'package:mental_health/presentation/bottomNavBar/bloc/nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(NavChanged(index: 0)) {
    on<NavigateTo>((event, emit) {
      emit(NavChanged(index: event.index));
    });
  }
}
