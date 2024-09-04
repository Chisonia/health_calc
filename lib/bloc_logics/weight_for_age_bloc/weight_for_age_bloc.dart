import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'weight_for_age_event.dart';
part 'weight_for_age_state.dart';

class WeightForAgeBloc extends Bloc<WeightForAgeEvent, WeightForAgeState> {
  WeightForAgeBloc() : super(WeightForAgeInitial()) {
    on<WeightForAgeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
