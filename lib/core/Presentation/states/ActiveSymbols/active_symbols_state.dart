import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';

/// Base state for active symbol
abstract class ActiveSymbolState {}

/// Initial state for active symbol
class ActiveSymbolInitialState extends ActiveSymbolState {}

/// Loading state for active symbol
class ActiveSymbolLoadingState extends ActiveSymbolState {}

/// Loaded state for active symbol
class ActiveSymbolLoadedState extends ActiveSymbolState {
  /// Initializes
  ActiveSymbolLoadedState({
    required this.activeSymbols,
  });

  /// Active symbols
  final List<ActiveSymbol> activeSymbols;
}

/// Error state for active symbol
class ActiveSymbolErrorState extends ActiveSymbolState {
  /// Initializes
  ActiveSymbolErrorState(this.errorMessage);

  /// Error message
  final String errorMessage;
}
