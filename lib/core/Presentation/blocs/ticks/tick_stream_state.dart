part of 'tick_stream_cubit.dart';

/// TicksState
abstract class TickStreamState {
  /// Initializes
  TickStreamState();
}

/// TicksLoading
class TicksLoading extends TickStreamState {
  @override
  String toString() => 'TicksLoading...';
}

class TicksInitial extends TickStreamState {}

/// TicksError
class TicksError extends TickStreamState {
  /// Initializes
  TicksError(this.message);

  /// Error message
  final String? message;

  @override
  String toString() => 'TicksError';
}

/// TicksLoaded
class TicksLoaded extends TickStreamState {
  /// Initializes
  TicksLoaded(this.tick);

  /// Loaded tick
  final Tick? tick;

  @override
  String toString() => 'Tick $tick loaded';
}
