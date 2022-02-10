import 'dart:async';
import 'package:deriv_app_sample/core/Presentation/blocs/ActiveSymbols/active_symbol_cubit.dart';
import 'package:deriv_app_sample/core/Presentation/blocs/ActiveSymbols/active_symbols_state.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import 'package:deriv_app_sample/core/Presentation/blocs/AvailableContracts/available_contracts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_deriv_api/api/contract/contracts_for/contracts_for_symbol.dart';

import 'package:flutter_deriv_api/api/contract/contracts_for/exceptions/contract_for_symbol_exception.dart';
import 'package:flutter_deriv_api/basic_api/generated/api.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/bloc_manager.dart';

/// AvailableContractsBloc
class AvailableContractsCubit extends Cubit<AvailableContractsState> {
  /// Initializes
  AvailableContractsCubit() : super(AvailableContractsLoading()) {
    // activeSymbolsBloc.stream.listen((ActiveSymbolsState activeSymbolsState) {
  }
  // });

  Future<void> fetchContracts(ActiveSymbolCubit activeSymbolsCubit) async {
    if (activeSymbolsCubit.state is ActiveSymbolsLoadedState) {
      final ContractsForSymbol contracts = await fetchAvailableContracts(
          activeSymbolsCubit.state.selectedSymbol);
      emit(
        AvailableContractsLoaded(contracts: contracts),
      );
    }
  }

  Future<ContractsForSymbol> fetchAvailableContracts(
    ActiveSymbol? selectedSymbol,
  ) async =>
      ContractsForSymbol.fetchContractsForSymbol(
        ContractsForRequest(contractsFor: selectedSymbol?.symbol),
      );
}
