import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import 'package:flutter_deriv_api/api/contract/contracts_for/contracts_for_symbol.dart';
import 'package:flutter_deriv_api/api/contract/models/available_contract_model.dart';

import 'package:flutter_deriv_bloc_manager/manager.dart';

/// Interface for blocs that need ActiveSymbols.
abstract class AvailableContractEventListener implements BaseEventListener {
  /// on ActiveSymbols loaded event handler.
  void onContractLoaded(final ContractsForSymbol? availableContracts);

  /// on ActiveSymbols loading event handler.
  void onContractLoading();

  /// On ActiveSymbols error event handler.
  void onContractError(String error);
}
