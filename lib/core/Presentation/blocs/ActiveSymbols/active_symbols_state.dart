import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';

abstract class ActiveSymbolsState {
  const ActiveSymbolsState({
    this.selectedSymbol,
  });

  /// Markers list.
  final ActiveSymbol? selectedSymbol;
}

class ActiveSymbolsInitialState extends ActiveSymbolsState {}

class ActiveSymbolsLoadingState extends ActiveSymbolsState {}

class ActiveSymbolsLoadedState extends ActiveSymbolsState {
  ActiveSymbolsLoadedState({
    this.activeSymbols,
    ActiveSymbol? selectedSymbol,
  }) : _selectedSymbol = selectedSymbol ?? activeSymbols?.first;

  List<ActiveSymbol>? activeSymbols;
  final ActiveSymbol? _selectedSymbol;

  /// Selected symbol
  ActiveSymbol? get selectedSymbol => _selectedSymbol;
  @override
  String toString() => 'ActiveSymbolsLoaded ${activeSymbols!.length} symbols';
}

class ActiveSymbolsErrorState extends ActiveSymbolsState {
  ActiveSymbolsErrorState(this.errorMessage);

  final String errorMessage;
}

// class ActiveSymbolSelectedState extends ActiveSymbolsState {
//  ActiveSymbolSelectedState({
//     this.activeSymbols,
//     ActiveSymbol? selectedSymbol,
//   }) : _selectedSymbol = selectedSymbol ?? activeSymbols?.first;

//   List<ActiveSymbol>? activeSymbols;
//   final ActiveSymbol? _selectedSymbol;

//   /// Selected symbol
//   @override
//   ActiveSymbol? get selectedSymbol => _selectedSymbol;
//   @override
//   String toString() => 'ActiveSymbolsLoaded ${activeSymbols!.length} symbols';
// }