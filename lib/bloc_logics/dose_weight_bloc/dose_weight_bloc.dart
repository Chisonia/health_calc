import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dose_weight_event.dart';
part 'dose_weight_state.dart';

class DoseWeightBloc extends Bloc<DoseWeightEvent, DoseWeightState> {
  DoseWeightBloc() : super(DoseWeightInitial()) {
    on<DoseWeightEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
