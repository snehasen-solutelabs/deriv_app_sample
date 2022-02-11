import 'package:flutter_deriv_api/api/common/tick/tick.dart';

/// Base state for tick stream
abstract class TickStreamState {
  /// Initializes tick stream base state
  const TickStreamState({required this.ticks, required this.pipSize});

  /// Ticks list
  final List<Tick> ticks;

  /// Pip size
  final int pipSize;
}

/// Tick stream initial state
class TickStreamInitialState extends TickStreamState {
  /// Initializes tick stream initial state
  const TickStreamInitialState({required int pipSize})
      : super(ticks: const <Tick>[], pipSize: pipSize);
}

/// Tick stream update state
class TickStreamUpdateState extends TickStreamState {
  /// Initializes tick stream update state
  const TickStreamUpdateState({
    required int pipSize,
    List<Tick> ticks = const <Tick>[],
  }) : super(ticks: ticks, pipSize: pipSize);
}

/// Tick stream error state
class TickStreamErrorState extends TickStreamState {
  /// Initializes
  const TickStreamErrorState({this.errorMessage})
      : super(ticks: const <Tick>[], pipSize: 0);

  /// Error message
  final String? errorMessage;
}
