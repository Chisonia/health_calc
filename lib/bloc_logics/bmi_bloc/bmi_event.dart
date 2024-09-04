part of 'bmi_bloc.dart';

abstract class BmiEvent extends Equatable {
  const BmiEvent();

  @override
  List<Object> get props => [];
}

class CalculateBmi extends BmiEvent {
  final double weight;
  final double height;

  const CalculateBmi(this.weight, this.height);

  @override
  List<Object> get props => [weight, height];
}