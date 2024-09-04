part of 'gestational_age_bloc.dart';

sealed class GestationalAgeState extends Equatable {
  const GestationalAgeState();
}

final class GestationalAgeInitial extends GestationalAgeState {
  @override
  List<Object> get props => [];
}
