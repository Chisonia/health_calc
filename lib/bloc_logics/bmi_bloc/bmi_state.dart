part of 'bmi_bloc.dart';

abstract class BmiState extends Equatable {
  const BmiState();

  @override
  List<Object> get props => [];
}

class BmiInitial extends BmiState {}

class BmiCalculated extends BmiState {
  final double bmi;

  const BmiCalculated(this.bmi);

  @override
  List<Object> get props => [bmi];
}
