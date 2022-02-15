import 'dart:async';
import 'package:deriv_app_sample/core/Presentation/states/AvailableContracts/available_contracts_state.dart';
import 'package:deriv_app_sample/core/bloc_manager/event_listener_contracts/select_symbol_event_listner.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/api/contract/contracts_for/contracts_for_symbol.dart';
import 'package:flutter_deriv_api/basic_api/generated/api.dart';

/// AvailableContractsCubit
class AvailableContractsCubit extends Cubit<AvailableContractsState>
    implements SelectActiveSymbolEventListener {
  /// Initializes
  AvailableContractsCubit() : super(AvailableContractsLoading());

  Future<void> fetchAvailableContract(
      {required ActiveSymbol selectedSymbol,
      bool showLoadingIndicator = true}) async {
    try {
      if (showLoadingIndicator) {
        emit(AvailableContractsLoading());
      }

      final ContractsForSymbol contracts =
          await _fetchAvailableContracts(selectedSymbol);
      emit(
        AvailableContractsLoaded(contracts: contracts),
      );
    } on Exception catch (e) {
      emit(AvailableContractsError('$e'));
    }
  }

  Future<ContractsForSymbol> _fetchAvailableContracts(
    ActiveSymbol selectedSymbol,
  ) async =>
      ContractsForSymbol.fetchContractsForSymbol(
        ContractsForRequest(contractsFor: selectedSymbol.symbol),
      );
  @override
  void onSelectActiveSymbol(ActiveSymbol selectedSymbol) {
    fetchAvailableContract(selectedSymbol: selectedSymbol);
  }
}
