import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bmi_event.dart';
part 'bmi_state.dart';

class BmiBloc extends Bloc<BmiEvent, BmiState> {
  BmiBloc() : super(BmiInitial());

  Stream<BmiState> mapEventToState(BmiEvent event) async* {
    if (event is CalculateBmi) {
      final bmi = event.weight / (event.height * event.height);
      yield BmiCalculated(bmi);
    }
  }
}
