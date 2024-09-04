part of 'drops_minute_bloc.dart';

sealed class DropsMinuteState extends Equatable {
  const DropsMinuteState();
}

final class DropsMinuteInitial extends DropsMinuteState {
  @override
  List<Object> get props => [];
}
