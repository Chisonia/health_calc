import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'drops_minute_event.dart';
part 'drops_minute_state.dart';

class DropsMinuteBloc extends Bloc<DropsMinuteEvent, DropsMinuteState> {
  DropsMinuteBloc() : super(DropsMinuteInitial()) {
    on<DropsMinuteEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
