import 'dart:async';
import 'package:deriv_app_sample/core/Presentation/state/AvailableContracts/available_contracts_state.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/api/contract/contracts_for/contracts_for_symbol.dart';
import 'package:flutter_deriv_api/basic_api/generated/api.dart';

/// AvailableContractsCubit
class AvailableContractsCubit extends Cubit<AvailableContractsState> {
  /// Initializes
  AvailableContractsCubit() : super(AvailableContractsLoading());

  Future<void> onLoadedSymbol(ActiveSymbol? selectedSymbol) async {
    final ContractsForSymbol contracts =
        await fetchAvailableContracts(selectedSymbol);
    emit(
      AvailableContractsLoaded(contracts: contracts),
    );
  }

  Future<ContractsForSymbol> fetchAvailableContracts(
    ActiveSymbol? selectedSymbol,
  ) async =>
      ContractsForSymbol.fetchContractsForSymbol(
        ContractsForRequest(contractsFor: selectedSymbol?.symbol),
      );
}
