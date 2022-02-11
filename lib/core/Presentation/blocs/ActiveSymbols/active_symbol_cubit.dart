import 'dart:async';
import 'package:deriv_app_sample/core/Presentation/blocs/AvailableContracts/available_contracts_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import 'package:flutter_deriv_api/basic_api/generated/api.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/bloc_manager.dart';
import 'active_symbols_state.dart';

class ActiveSymbolCubit extends Cubit<ActiveSymbolsState> {
  ActiveSymbolCubit() : super(ActiveSymbolsInitialState());
  static const String _activeSymbolType = 'brief';
  static const String _productType = 'basic';

  Future<void> fetchSymbols({bool showLoadingIndicator = true}) async {
    try {
      if (showLoadingIndicator) {
        emit(ActiveSymbolsLoadingState());
      }

      final List<ActiveSymbol> activeSymbols = await _fetchActiveSymbols();
      ActiveSymbol selectedSymbol = activeSymbols.first;
      emit(
        ActiveSymbolsLoadedState(
            activeSymbols: activeSymbols, selectedSymbol: selectedSymbol),
      );

      // updating Contract List
      BlocManager.instance.fetch<AvailableContractsCubit>();

      BlocManager.instance
          .fetch<AvailableContractsCubit>()
          .onLoadedSymbol(selectedSymbol);
    } on Exception catch (e) {
      emit(ActiveSymbolsErrorState('$e'));
    }
  }

// on select from List
  Future<void> onSelectActiveSymbols(
      ActiveSymbol symbol, List<ActiveSymbol>? list) async {
    emit(
      ActiveSymbolsLoadedState(activeSymbols: list, selectedSymbol: symbol),
    );
  }

// initial load
  Future<void> onLoadedSymbol(
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
