import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gestational_age_event.dart';
part 'gestational_age_state.dart';

class GestationalAgeBloc extends Bloc<GestationalAgeEvent, GestationalAgeState> {
  GestationalAgeBloc() : super(GestationalAgeInitial()) {
    on<GestationalAgeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
