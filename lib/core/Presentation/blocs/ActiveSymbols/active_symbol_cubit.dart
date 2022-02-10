import 'dart:async';

import 'package:deriv_app_sample/core/Presentation/widgets/active_symbols_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';

import 'package:flutter_deriv_api/basic_api/generated/api.dart';

import 'active_symbols_state.dart';

/// ActiveSymbolsBloc
class ActiveSymbolCubit extends Cubit<ActiveSymbolsState> {
  ActiveSymbolCubit() : super(ActiveSymbolsInitialState());
  static const String _activeSymbolType = 'brief';
  static const String _productType = 'basic';

  Future<void> fetchActiveSymbols({bool showLoadingIndicator = true}) async {
    try {
      if (showLoadingIndicator) {
        emit(ActiveSymbolsLoadingState());
      }

      final List<ActiveSymbol> activeSymbols = await _fetchActiveSymbols();
      emit(
        ActiveSymbolsLoadedState(activeSymbols: activeSymbols),
      );
    } on Exception catch (e) {
      emit(ActiveSymbolsErrorState('$e'));
    }
  }

  Future<void> onSelectActiveSymbols(
      ActiveSymbol symbol, List<ActiveSymbol>? list) async {
    emit(
      ActiveSymbolsLoadedState(activeSymbols: list, selectedSymbol: symbol),
    );
  }

  Future<List<ActiveSymbol>> _fetchActiveSymbols() =>
      ActiveSymbol.fetchActiveSymbols(
        const ActiveSymbolsRequest(
          activeSymbols: _activeSymbolType,
          productType: _productType,
        ),
      );
}
