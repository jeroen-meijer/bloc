import 'package:equatable/equatable.dart';

abstract class StatsState extends Equatable {
  const StatsState();

  @override
  List<Object> get props => [];
}

class StatsLoadInProgress extends StatsState {}

class StatsLoadSuccess extends StatsState {
  const StatsLoadSuccess(this.numActive, this.numCompleted);

  final int numActive;
  final int numCompleted;

  @override
  List<Object> get props => [numActive, numCompleted];

  @override
  String toString() {
    return 'StatsLoadSuccess { '
        'numActive: $numActive, '
        'numCompleted: $numCompleted, '
        '}';
  }
}
