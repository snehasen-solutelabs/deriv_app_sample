import 'package:flutter_deriv_api/api/contract/contracts_for/contracts_for_symbol.dart';
import 'package:flutter_deriv_bloc_manager/manager.dart';

/// Interface for blocs that need Contract.
abstract class AvailableContractEventListener implements BaseEventListener {
  /// on Contract loaded event handler.
  void onContractLoaded(ContractsForSymbol? availableContracts);

  /// on Contract loading event handler.
  void onContractLoading();

  /// On Contract error event handler.
  void onContractError(String error);
}
