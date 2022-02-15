import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import 'package:flutter_deriv_api/basic_api/generated/api.dart';

import 'active_symbols_state.dart';

class ActiveSymbolCubit extends Cubit<ActiveSymbolState> {
  ActiveSymbolCubit() : super(ActiveSymbolInitialState());
  static const String _activeSymbolType = 'brief';
  static const String _productType = 'basic';

  Future<void> fetchActiveSymbols({bool showLoadingIndicator = true}) async {
    try {
      if (showLoadingIndicator) {
        emit(ActiveSymbolLoadingState());
      }

      final List<ActiveSymbol> activeSymbols = await _fetchActiveSymbols();
      emit(
        ActiveSymbolLoadedState(activeSymbols: activeSymbols),
      );
    } on Exception catch (e) {
      emit(ActiveSymbolErrorState('$e'));
    }
  }

  Future<List<ActiveSymbol>> _fetchActiveSymbols() =>
      ActiveSymbol.fetchActiveSymbols(
        const ActiveSymbolsRequest(
          activeSymbols: _activeSymbolType,
          productType: _productType,
        ),
      );
}
