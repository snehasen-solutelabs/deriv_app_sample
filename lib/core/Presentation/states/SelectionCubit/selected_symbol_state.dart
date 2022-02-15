import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';

///Selected Symbol base State
abstract class SelectedSymbolState {}

/// Selected Symbol initial state
class SelectedSymbolInitialState extends SelectedSymbolState {}

/// Selected Symbol change state
class SelectSymbolChangeState extends SelectedSymbolState {
  /// Initialises Selected Symbol change state
  SelectSymbolChangeState({required this.selectedActiveSymbol});

  /// Selected Symbol details.
  final ActiveSymbol selectedActiveSymbol;
}
